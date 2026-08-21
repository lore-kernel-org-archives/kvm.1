Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33954763
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314916; cv=none; b=SqRVQS9mqj8V64hrVtKQM7QA5NDiYYSkkEK+aXiFBCwJiK4aeyfFywKFlC9DnvnbdQYKnbtgaUoZh5SV8OfQNRBn6SW7S9ggbKlO6vnQd8HmBM72+8HJVPJW1XA60pi2i7SKlsMaRcJlLU1v51+ySoOVjcHRXfMhYLZGY0WyVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314916; c=relaxed/simple;
	bh=vDG6VgGLB1ibhVtC5i7RLaGRct1dwqYniHcqmrujC5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=claf9U0/S86NpneoNHE5W+eE04Nb+rzURsQa9pq2AMtSd2M7elPEl1s8OcP1TfL/VH10/YLbSuS6FHVMQCnHFiJLz8lH+iczpyRsl2bnIH2fWejDT9en3/CBXYOTsz+wBN7WI01UsWbDAbiMHGUlnwikTE2WDL7uiLP3WzomjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STcQjtVn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STcQjtVn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so2242043a12.1
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314907; x=1787919707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+VklefX138oVd49VIDXjzUaX4u45OfIRfPWaoTXpLM=;
        b=STcQjtVnhubjh6QKj0fJ3DoJXoGFqP58Oyz+IBpjarDCY90bWXYvALd2HP6wyqkew5
         2VDBk/No1O8etONMCzYA5xQ1PQ6terYp/ALM0MlQgoYr5TMYAvHrtz5Cfb4bVriyre6f
         CzHO3X4SteeSg2IbBKmZHNumLWDBiKOIOFZlNa5KqG68fDEE7pwnrHzk8eRJevbQU2qi
         +IuOdG8cIzf3Vrl0cfEMP8FZOpb4B6fZvTLVzipuG6lXCRRC4zkKbW8Z+51Qb/UxKJDq
         GWlu3fxxsWs80/a8k3UyrKF2uNaSote1eg4xJZtJ/W+a8FyhGN6Zt8DmNpNANJkpzS1Z
         EyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314907; x=1787919707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+VklefX138oVd49VIDXjzUaX4u45OfIRfPWaoTXpLM=;
        b=qyU8+GYVUyZvWtPhfEAEE3EWgMrAIzYO5lMb8PCYiZpQ1vFdscZ0HEREyc0OuOtkua
         +vExkPn1D2hE4i7nrF7Vt9H/J36feqg/PXpMhImfuqz27GKEH4VkdM0zqRIpPZpdCceU
         zA3EPT7Hfqnuyhes8NI/4xRIK9ChpYOTnMv/88vL/vXLy5KH0ufcY1ZLYbzCX34EiSe+
         0Z0nBufTHSnxhBbSIP8p9YXJzvGxzoyVptM8pBQLCAkTj2GVNVdPB9XrCrfUsOkq2XUq
         cc1G2yMqhJX13YvUUVwuaxVrNdbdNwv8cem128CujoXWjpKhbPZLv3mX4JZgUqyZf14O
         p+kQ==
X-Gm-Message-State: AFuF++nMGzSqkty/6voj7xD+DzIy3dLp9iIz5HDRqeaU1Lik9JbrV44v
	8L3ijeSzL68IjTf4wn3yIqXnEKmG/Oh1n0qLU9cSB4KUCdzXtORurxIzqIlPxJgzAiA5mw==
X-Gm-Gg: AR+sD12zyTn65WkUjxN7zp368fJxsKletG2msmDDDRji786Wdp0VEPE1mB4CuSPyUoK
	HIQE0s3wLEpInoo7GUF2QxWbC3QtRSwKRus68M+zx8PBkEuIGJxHxO/IQ3C/D5d6wjMB/miKi1m
	TdVHcwJi9+LwazK2G9cep/pKjKKnittcqRA1v03RPwbFxl9UxyNOLM5PvrM8hH3mKTcL9HOXRme
	zud30/R7RzErNcFSVRN1Ad4rWdpzxDr0GschC9kr94v2e8u6kvcVMDIF4Ok6AAcBITSZ8xOosb5
	vXFDh7Wx9mrSruMeuMcYri8lAX29BEvuYbLrIq6qnfwy97y5IvFlhRcbbMyqSvlBx3UOuG3WZ+F
	vMUxjBsHRPVdimqotS2uTCv2O6plgrr8IvLZdHUVEmi4E9yeYbh3bl5T9OW6Ebq8r5VYYW9JWtj
	Q9UcQpRbbAb602hBUFUCsxuV0MhFkdakSRvFGivcvQR/qnIFuz+Sbkd3sruEc+t52/SWbp9Ou44
	ld85IpomI8o8gVH/H8eaUI=
X-Received: by 2002:a05:6402:23c1:b0:6a3:ec9f:7e3d with SMTP id 4fb4d7f45d1cf-6a4112fafdcmr9645391a12.6.1787314907216;
        Fri, 21 Aug 2026 05:21:47 -0700 (PDT)
Received: from hisam ([2407:d000:508:2027:f309:cd0f:ed5a:5b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177b1esm6473776a12.29.2026.08.21.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:21:46 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: kvm@vger.kernel.org
Cc: dmatlack@google.com,
	alex@shazbot.org,
	shuah@kernel.org,
	seanjc@google.com,
	jrhilke@google.com,
	rananta@google.com,
	vipinsh@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH] selftests/vfio: Include <libgen.h> for basename() on non-glibc builds
Date: Fri, 21 Aug 2026 17:21:11 +0500
Message-ID: <20260821122110.902382-2-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.c calls basename() but does not include its declaration.
Glibc exposes basename() through <string.h> with _GNU_SOURCE, while
musl declares it in <libgen.h>.

With musl, this results in an implicit-function-declaration error and
subsequent type-mismatch errors at the callers.

Include <libgen.h> so the declaration is available on both glibc and
musl. This is safe at both call sites: the arguments are local writable
char[PATH_MAX] buffers filled by readlink_safe().

Link: https://lore.kernel.org/kvm/CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com/
Fixes: a262fc49e0aa ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
 tools/testing/selftests/vfio/lib/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 11415448b2e2..daf117a299a6 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <fcntl.h>
+#include <libgen.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.51.0

