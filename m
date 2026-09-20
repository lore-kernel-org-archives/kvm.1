Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FF472099
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933025; cv=none; b=kd75SBM3y34gDUCA35a0tdApBQgdMxVWdD6femvT2Ux54Hgjh2TNUOoeobF/jj+0GsCUtBVyh9+zcrgRzS0cdd4P6D1qxQHgH+ID51tVdSv5auW/l+snKQS/Tq/fM0ZwJGewyuGwGQ6tGZ7aSyqrFkVspRmAaA8IhAlOhrVaesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933025; c=relaxed/simple;
	bh=VA+J8gVgQJjXgqa1KyYAn5D2Rm8bdS8GTWaA8o/nJp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhWKJlwfqUNqVcqukiGoIZMQbWaKTp9hCE14KHZrFnLjoULpsLXHR5GhU9QAnAHvj6GtkOXvsCMkOcnxiqWGCXwk3qipYZuIXeYVWt3gzq9GY51TCR3gYgnFYa83NWJ+zGDn6vgv+erHziMLD6nLGX+6jgqJ/QFMRZ0pDB3tFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OnxKCQgg; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OnxKCQgg"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae3149so1690631d50.2
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933021; x=1790537821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=OnxKCQggUjQqoznbKxu09+qRorCvxffDk3SmFn527NA55cWPRdy/PScEVe9s3Buus3
         1Jp5qS6lg0T4urvb21OzMTgXlVebEkisSXt9ByokhpX+VL5ENTLCQCnV+afhh872YCQw
         exl+pBgBaT2deItwcBfgubRkxvt3F9703kqhFLXEZfcT3C9tijVHKNkG3fm63QrTtKnv
         f6CDvHmUdT6CxWdcoZthyBd1tKjoEN9lj+kDjEj/SQ7A6B32L6mVp4MeAUUB9BlqZtpZ
         Knzj/BwL0Et3K8nbwFbktaEpI9/e12TFDd96oXXQLFDJCb4pfXWN+55ehtaNEk0OvuIQ
         EQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933021; x=1790537821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=Zo6QsRaXKWpSuKS7Km8cwFnZHj04mA0xqL3LNgWzLBGtWMfD1OWYWxYRoGlBLOouFi
         Ce9dti99IchbHdNcF6IFuc31u13yD3S1/fOuqtjPP/BhK7rnCW6VcQKZTWoJOglIY9hK
         sBC2ijskFyvmNzIlwpXPyNug5wfFQvWfxw4Yoz599h0hMw0mokI7rjAqLPlDxK6/hc/v
         b4GOXHrSTcRZ92GzsqtM0Z8/LMPoVmlw0p6gvPKoj81H95PyqdZV+enzAU6YayhGM1Lj
         gBD727KlyZSKqJxBVY8VE0tyCkjf0e5cHVyLborySZ5cmPyH9TlUnGZfnaYMfkwHou7Y
         +arA==
X-Forwarded-Encrypted: i=1; AKwUvBw79aGI/in5EyGP5faUgsNWyB903BaRr5oilit05bhu7ZwksWqeGQnu6W4Ti839NBtA23g=@vger.kernel.org
X-Gm-Message-State: AFuF++kVSrh65Ed/KnP6TtrPeBw4GNF3NeTjfSplLVdDquwir6c5owGe
	Afd9VywwJm2dBeXAxQ/FEjXVP95ThyqRJGdYVEf6Pm1o6sgnpabhIlvXFUgGA3/mzNY=
X-Gm-Gg: AYBFou3c+u3uhFrBH3uzMJ3hoedzvG96Jzry4fByZZ1ovkwIUqhcWLe2vyGLMuNi8Pn
	l/qLv3havxV1v/+wwd60kQ5p0/1wdN9WOvGWcmMzeC6dIBL1N9ZCKKyKj0AgI+z1XBRIs2TPFkU
	LF4BSvuHyzw1TnxiqcoE4CzQb5jquEc4ES2+v3OadP8ZsduWqi3dhFADKkchA8iYoJ+cTf8zWmV
	GcaLVYYjOafE8EAkJ6xA6Aijf2wQUB8NliK42sqG5ube907xb20zLV14RRQXEiIeV6LI8Mq8mPm
	o+JnYVe/8Y0bhKXagwdSIBddO7GQpcA8VUwxAVeUeFl/ScgMyiH8qKumetjjCn39MS41PGXaG5O
	D4ZbdvR3KSaIc9pRXj6zysJm5Ft+VLuav3sDNf2z8suKVQVPrTVGhhi9vsfRba4s2qsxFv20V32
	9+Yvw6UVa6okX1O11H46sr1aM9/4EPLMOqMfCHZX6Ss4NVMRjYZ6js4IiZralf7B/1TNvXVTpFK
	2KCi3z2nQs7DmQVV3MZz54ctCL9shWF495TMTTFA0+edwi2xj/NW3QPkAmQXJDO/0Zr6wLpbGFU
	V1nMlW0cJ0LFDIDPJOI=
X-Received: by 2002:a05:690e:11c7:b0:672:a2ee:6155 with SMTP id 956f58d0204a3-672a2ee6b7cmr1008959d50.45.1789933021253;
        Sun, 20 Sep 2026 12:37:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299146eb0sm2607555d50.21.2026.09.20.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:00 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 01/46] KVM: luo: Delegate VM creation type to kvm_arch_vm_luo_preserve
Date: Sun, 20 Sep 2026 15:36:05 -0400
Message-ID: <20260920193650.3373435-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the architecture-specific #ifdef ladder setting ser->type in
kvm_luo_preserve(). Leaving ser->type zero by default allows
kvm_arch_vm_luo_preserve() to populate the architecture-defined VM
creation flags without referencing unexported architecture symbols in
generic KVM code.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 virt/kvm/kvm_luo.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
index 025b53151b6a..b3bd9bebe17a 100644
--- a/virt/kvm/kvm_luo.c
+++ b/virt/kvm/kvm_luo.c
@@ -73,16 +73,13 @@ static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
-#if defined(CONFIG_X86)
-	ser->type = kvm->arch.vm_type;
-#elif defined(CONFIG_ARM64)
-	ser->type = kvm_phys_shift(&kvm->arch.mmu);
-	if (kvm_vm_is_protected(kvm))
-		ser->type |= KVM_VM_TYPE_ARM_PROTECTED;
-
-#else
+	/*
+	 * @type is the argument the new kernel will pass to KVM_CREATE_VM, and
+	 * only the architecture knows how to spell it.  kvm_arch_vm_luo_preserve()
+	 * fills it in; leaving it zero here is the right answer for an
+	 * architecture that does not implement the hook.
+	 */
 	ser->type = 0;
-#endif
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
@@ -115,7 +112,6 @@ static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
 	kvm = file->private_data;
 
 	args->file = file;
-	kho_restore_free(ser);
 
 	kvm_uevent_notify_vm_create(kvm);
 	return 0;
@@ -147,11 +143,7 @@ static void kvm_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct kvm_luo_ser *ser;
 
-	/*
-	 * If retrieve_status is true or set to error, nothing to do here.
-	 * Already cleaned up in kvm_luo_retrieve().
-	 */
-	if (args->retrieve_status)
+	if (args->retrieve_status < 0)
 		return;
 
 	if (!args->serialized_data)
-- 
2.55.0.1082.g2b9226bbc0-goog

