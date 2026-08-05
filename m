Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49734322F0;
	Wed,  5 Aug 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927830; cv=none; b=dUnMfNrQLK6iTmm2oV9fDS23VXvPXxPkojB3AMImDsXypG6Y23Y4eES8+zzJVwAqEE+T976EMfkXOaBG7XOY4IME2RUrXrKMcOIXVGxQBQIPLEkL3ZLrK4sau54kEa9w/SbNiZLoSN3eSy6gM8ouKybasw8vthYkN9VjX3MfwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927830; c=relaxed/simple;
	bh=VYNZzZDfqdSOu7Tj0KRWvIM0pNL5XYyX5tJhmoeWU1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIFE1/qzyF/ZX/yzqWGO3ssWRdDZyry6gqh8OtATn8lY6NhD3NQWaUSbVDv8ceqKuxO7wH2B0UqJnRnBW6sCnZvUMvjoRIAMT9WrdMYGzMzkGfg2TW64xV7l9tJIpPzw7Jxk19GQKxXDg1vv+cvfND+dmdwOISmB0QJRwzKyLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GcRBX0jD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GcRBX0jD"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id B97AD20B7169;
	Wed,  5 Aug 2026 04:03:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B97AD20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927808;
	bh=/YcaorVByUQCvbkLO88pJPdr2y/0TEfivReyfVIvkQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcRBX0jDljIsTTfRfQ7YEzdimdta21ku4VQ1/bkvZugLCM3GjLsFuVQ81aAiBCI0S
	 KtwYxIEeVFLY6h3hEQP5MpM/bSDOsqtSjDxNhHKpg3r9VA7NtbStWRosErltvQfeSD
	 p25Xepxfao+6C2S05POhmLNeHqSCjSJQuPpie+1g=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 08/42] Add plane config param to specify kernel image format
Date: Wed,  5 Aug 2026 04:02:50 -0700
Message-ID: <20260805110324.25067-9-snambakam@linux.microsoft.com>
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

---
 include/linux/vm_planes.h |  9 +++++++++
 init/vm_planes.c          | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 506de566cbd5..6d0066f70349 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -9,14 +9,23 @@
 
 #define VM_PLANE_KERNEL_NAME_MAX	128
 
+enum vm_plane_kernel_format {
+	VM_PLANE_KFMT_RAW = 0,
+	VM_PLANE_KFMT_BZIMAGE,
+	VM_PLANE_KFMT_ELF,
+};
+
 struct vm_plane_config {
 	phys_addr_t load_offset;
 	phys_addr_t memory_size;
 	unsigned int vcpu_count;
+	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 };
 
 void __init arch_init_vm_planes(void);
+void __init load_vm_plane_kernels(unsigned int plane_count,
+				  struct vm_plane_config *plane_cfg);
 
 #endif /* CONFIG_VM_PLANES */
 
diff --git a/init/vm_planes.c b/init/vm_planes.c
index ecfe8de409a8..da9c17de4a44 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -8,8 +8,10 @@
 #include <linux/string.h>
 #include <linux/kvm_para.h>
 #include <linux/vm_planes.h>
+#include <linux/elf.h>
 #include <asm/cpu.h>
 #include <asm/kvm_para.h>
+#include <asm/io.h>
 
 #ifdef CONFIG_VM_PLANES
 static bool __initdata enable_vm_planes_requested;
@@ -21,6 +23,7 @@ struct vm_plane_parse_state {
 	phys_addr_t load_offset;
 	phys_addr_t memory_size;
 	unsigned int vcpu_count;
+	unsigned int kernel_format;
 	char kernel[VM_PLANE_KERNEL_NAME_MAX];
 };
 
@@ -209,6 +212,23 @@ static int __init parse_plane_cfg_line(const char *line, size_t len,
 		return 0;
 	}
 
+	if (!strcmp(key, "KERNEL_FORMAT")) {
+		unsigned int fmt;
+
+		if (!strcasecmp(val, "raw"))
+			fmt = VM_PLANE_KFMT_RAW;
+		else if (!strcasecmp(val, "bzimage"))
+			fmt = VM_PLANE_KFMT_BZIMAGE;
+		else if (!strcasecmp(val, "elf"))
+			fmt = VM_PLANE_KFMT_ELF;
+		else
+			return -EINVAL;
+
+		plane_cfg[plane_id].kernel_format = fmt;
+		state[plane_id].kernel_format = fmt;
+		return 0;
+	}
+
 	if (kstrtou64(val, 0, &parsed_u64))
 		return -EINVAL;
 
-- 
2.55.0

