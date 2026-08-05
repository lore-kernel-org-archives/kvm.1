Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFC446832;
	Wed,  5 Aug 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927844; cv=none; b=LrSdDh7ShKw4H7CBO8j2RyPxxX4Idni3LWvAJOo2jXaNkKv2/o40/Qbw7JLhRrdgpEUe6GAB7SwGrHJ0nootIpLNbcnXnu3mV47Dzh8xWYJtiRXfDsp0mXksyr8Vm2yXh3JoVAjK154AnShHoIfCNudN4Mp4al0O228as4/XI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927844; c=relaxed/simple;
	bh=S6ow6u37Nze3gz7SP5x0FBpghH++jtM7x4giyEkyIlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAWBAtzCUwOMeTbgkVlY7x+E7tvMaegecKhieAg8qhsYsAMbTmC+gQLYZis6nNJ8VtT6jzwwmKo8PQ6OqF7euGoeW2ufNHUaAt0YnE3WjWjdYbXW6wkoDNqO+0XTc8ZOqQpK4NxKPl9SZADYnugxnDClWh8sIlQoCF8ivNrrhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TpGaLzwr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TpGaLzwr"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 396DA20B716B;
	Wed,  5 Aug 2026 04:03:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 396DA20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927822;
	bh=grQj36QjcJA5uMMqT2x4FOxuTqkiGj6jowV9c9yKi9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpGaLzwrd/4GBHLJHYK9vQ72OQY3iu75uIj354S4IM8VTSOaJPCSuzAPWb8JPCIh9
	 olb/PPMSRB/Tvk+/mwDn9kPWlBGmMhk1kij9bZ6QmybY8/6AsagJMYi9E1X6K6H1rc
	 MhzrGy+PBOOU6tnEWlRzeCQzfe4cX6YvNw5aprb0=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 22/42] kexec: block legacy kexec_load when VBS is active
Date: Wed,  5 Aug 2026 04:03:04 -0700
Message-ID: <20260805110324.25067-23-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy kexec_load accepts raw memory segments and bypasses the
file-based VBS validation path. Reject non-crash usage when a VBS
backend is registered to prevent untrusted payload staging.

Crash dumps (KEXEC_ON_CRASH) are still permitted since they serve a
different purpose and do not replace the running kernel.

Returns -EKEYREJECTED so userspace can distinguish VBS policy denial
from permission errors.
---
 kernel/kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 90756dc6339b..049afe1e1f5d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/vbs.h>
 
 #include "kexec_internal.h"
 
@@ -205,6 +206,15 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	int image_type = (flags & KEXEC_ON_CRASH) ?
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	int result;
+	bool crash_kexec = !!(flags & KEXEC_ON_CRASH);
+
+	/*
+	 * Legacy kexec_load accepts raw memory segments and bypasses the
+	 * file-based VBS validation path. Reject non-crash usage when VBS
+	 * is active to prevent untrusted payload staging.
+	 */
+	if (vbs_available() && !crash_kexec)
+		return -EKEYREJECTED;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
-- 
2.55.0

