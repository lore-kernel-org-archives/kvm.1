Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753C5111AB
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464233; cv=none; b=dqIYdJR9q9fbRUKUkLp4+hQgyRAIptW3/tkZOd0FITfIhbcafQMifcNZzgD9G/7Ca+q22RS+vZjSYid0SiKi0MJbpSdlKPF80g2UIblnAljNw9xWRs74MWV26t9t4cyZAqxNv5bzMT1xxVJyryukms2inBow6zwIS/IigCnj+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464233; c=relaxed/simple;
	bh=raMsDaYNdJirhs5aEJmf/QNzzXxHGIZgMckH+xgNqvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwCxUNxA8lAMFTk75ryIo6hsHVLVbsJezl/puTwB53/ejGUlo7RM6L/iOpXX4KaoCsLRzJqLJuqUd9iQJAuY87xPsI7eXHCiVDG/zzqHe2dePAUa64rvQX1gSUMwpTAEC1LShs9qtF6X3yCjr1UESnv/OwPyQ81rhyZ7GuQ+f18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QIUSlaVH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIUSlaVH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381b831d535so315657a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464214; x=1789069014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=QIUSlaVHIfyBaDdD8q700G8Q3mugDQWGnW3rJ0IjpP5zrmBaGxz0AR8Sd4ds4+kcIV
         v7usr1aO4iOb6gpdV0tWlReZDDKp+ShrQorZAE/7wtdsVSpSlc+MdpsenKBEy45n0RMO
         nDdMGnGMcTPzqq8qDUxlu6ZoLnOFPK1v1sZk4YWdemo3AAOIEmflMXryb63Aw7BW3OTv
         eDfRK5D1t3OK9za4ludaplg32OKpp6dkTXM0uD577jv+e7PHPwPg5v1ElgkGJkI9UzY6
         AdXbJTnI6dfeNGUqPbmaQMEtGqvLsOUftOCW6wIwXYSd6bxgMNwe+nKAyj7C6fC3ekot
         D6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464214; x=1789069014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpASq3jOBF00q1EZdBLVp0S8hhXgpRTHfBnK0kI8ssk=;
        b=NQDD738kY/O6xFUhIgY7ZRzMseJXjUGmAsGoFSzsyX90mGOe3VjKHUPg/5+DpIatKx
         X/TKBR8KdsjHkGU3iSyaMhHUEst/8N9ZPboKL+LWzWhLSuAtvTW055Ze8q+w9mw9JB1i
         nNClVMzDeYLz+kZnKp/R5n6L7emWAz8+M2S5IbMCxsFA/inSnjxN3+i+OTulxllgP0aB
         LAw3IzthQUlgLjxSjYIW4LvGpi8KNl6HVc8wTnaDtoHl6EQrhLsCjyyCaokerbn/FI0w
         Q6OkgqgG2YfekZ+YzQGIEDm7hNb3ids2uzPepp/R0wagjf2SgLgYhenQrgUJ+Ql0Gyhc
         jM3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzmBcD5Z6VbsUWVvaV6FXrSJK1r9b6ZHzxuzgXDgb5kPjoLQVMLpS74ZjJUvOVwcQ8EHbU=@vger.kernel.org
X-Gm-Message-State: AFuF++netCDZ55Z0fPPCuaBBDUjUx0CMJCIH3WZdIC+hWIHGLpHY2KnU
	3m/UZDa/21PROU4uzaOoRODk2u1JgQJJiLwZAhJ1pooDGF0mevIY01/OeCrbhr6G3+c=
X-Gm-Gg: AYBFou1z+jYNLeVvh16cSq9kP8JNVLr58dm+pAHrWkkCNWUFh8P3URq7tn8mdVz+20B
	GgIyDKeFu46IIjSg2kjyNkrhnvlc+5YEwBQMJIC6xlc6yYWlUvTWI8Y3YBUwdTwbYqqrYEBbQul
	WDVYyfSJgkWgRK0Z22SVrf1EBT6ALMLYO3BDLv22t7t21CPdpYAu7TFIRAF0iPfXvZwh6gaNHem
	nGY5fVX3U8B5kpkoLIk2KOlIWgzuNfWTv4LKom8sWu92dPM3V8YBZ8aJ69mF7r/SjDuthyrppOt
	VAyEPBHAPM67RGlPUJQLBYkM+/dAzLxfjTysiqR4eJ5kPkIvSg1G/YlwdV1iBL6wBSDBEJFOcKy
	zgYdN3fW08uceLBkw1Q9YwMUh/PB+rw+9V4tKVRfZcYhVFtGYb4LMPO6ooQxNhhH9ZX4DsjGIWf
	VwE5gFAiWUqP/N//V/YGFuYcQWT+iha9DG2lOPdSdlDyzsZOZ9gsw7XXxatF2Ki0cTA3nAFPQdr
	XCRyBoNHDUozck=
X-Received: by 2002:a17:90b:4fd2:b0:398:9be5:b416 with SMTP id 98e67ed59e1d1-39b2621e4edmr1288438a91.17.1788464214324;
        Thu, 03 Sep 2026 12:36:54 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:53 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 23/24] hw/arm/boot: Load DTB as is for confidential VMs
Date: Thu,  3 Sep 2026 13:36:10 -0600
Message-ID: <20260903193611.1058589-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e8efada209f..9b3d3558bcbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.43.0

