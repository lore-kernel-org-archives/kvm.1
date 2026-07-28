Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666A3AB273
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265474; cv=pass; b=BRmTCQ2hNQIUfTGdT3lIOdilX8uxsIO2g9Nr5EhX9L/IlngrAiy2u9M4s3mXpk4Bkv2qUGGRKZHzv8DUlFfYmpdub8Pbsm81+wKLB5mY85Py0WKwyy5yRgmNQ/FJlk5mYxRxgs0EZ755cc0362XjVII42RtzjDV/miwzxKBu+AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265474; c=relaxed/simple;
	bh=en6y12nD6z2Bz4VtKfi10Rf0QI7IKxSRAWL4X/LGqso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=J7X8ZceLiqcDleKbEtAfFLy5GBv1KsRGBeXfWhSsCXQ5Q7u+GUdu8s7uK/wWJ9hZWU1xQArkfRccS/r9PnpZOD1UZCpe45C9otY4ZgYvuqVXc+3mtywVjqSbMySHasqw+FJ87IWwhGE7O9NZf7a/RICOTdeHnXVD1yCu2e05ogU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf36Wg5i; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf36Wg5i"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1712a04ddaso28701966b.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265470; cv=none;
        d=google.com; s=arc-20260327;
        b=ekkDya0vsJzrZA4HkSnOUh5OKlqVJKeeeZDkd2IAV2EHqJoYUaIbXn27iNM4acBXH/
         9wfC1Qq10t2+1H9KsqudJ8UwnhmoA74A5kJTI/YcCjAkAE464WENAzxAcS2esIZKNhrf
         LmbF+URcj9Ym5+mZOsNjzR9RZeqIHyFzaQNwxN7KLuHY9BKpP8aLQHq6PDQrRUvg7ZHR
         BmHCbfQmRz/HSVUrK7wZ0d+x4Yk1MxnAiXOYajVBQ6ikV62Woy6KnClaOJQ+GTjXSOEr
         RHXfxsG9iuekaqinj0IIVsomtfXdvfF+DjjYLN2g/fQXdKiulb/Ntxn9JIJFg1NwfuGT
         4q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        fh=rCUy7KtT+diXrjLih2hR2XSaH3qwv+W7adLUkL3Shuo=;
        b=fp1NUpVlwEqeJXeOkVysWytbGyuOMIhpGZ+qY81hC+qrtO++eJ5Gc+F6jVxgwC1GRg
         yFETUuRNTYe9CUM3IKeJVEYER17bOJez99m7Y+xaWScHfCKC4QPtb6LuT9xiihMpSjnJ
         hxuaTwUEk7J0RQFYGibE4IUZgcWqbUUzcmOv/OFshqaRQ36JG/Pb22akC7TqHX8gQ9+Q
         AkPoDMi2QJt6V4Qflc5FI0JDHKpQ/cIgISSI/LdayJ/Dax0E5P1mtmSilPAjDno3h6T2
         Px4mjFrKhYoCG1ci9+BkEsSYgtvSCjq0V+ejASVYOEWnQii5OYzkXWQ9t07LXvcersv5
         v7dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265470; x=1785870270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        b=Sf36Wg5i2OahnYDAAwnaGSLNsWJmduDuf/kulZurPMXlUJFu1LmP/8hDGrilvXbi8K
         aN6sOpNXxAM1s5xm9pv/HtW7eP4kdAuT/2wvSFufJelTNOzcG/pgcLKFC8Uq46358pzo
         2O85pFA23T1xFUENZ7cpAeX19NtesbbFqTkH4ao/SQijIEJIsdjbeHDEbrwtSM0FrMzl
         z1wr1vktzxOGZDgbqh/OmwlTVJqvR6Xf7jAtAsE4WBV02z1rUFBITM6DI9NPnnLM47lp
         IRPZiIihuMM3XJPeTOxHByQrNjpAbxKw0TtKF5ZaEIO7VKHxVApffU1uDBZeabCRS2Jy
         4cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265470; x=1785870270;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=buyU6u9dALho6JmmML198FMGtVzLIfd7rAqco8wEleI=;
        b=s3GVSc9N+XWe0ElwtEmCd6jR8CFwIwEgti/Z35n/AR+Gv+DtFoikQRXWcSMMLPOG50
         b+HaeRIyfz4QY9u6EwzQfV+ACqWSGBhzVKHn06IhSUeImPFtTbNp0bw92/u+a/1+7G2U
         zfINbpOmtn32AgcFoKH3MwysLHj0k5yfB+IQJQNX7fSLJwiFxKQVAZV/qz6W2Dl/8HnW
         WjgPv170FcbcFrMsPObaFlJXhCo5F80xzlX6EHCZQl/5Ebl6dfzt+b6+g7/NZsxIi6fK
         j83WHhI9iKzS3RjV68F2ATj8SnNKs96ZVVH3NziEs+81dj9MXSFrmXRo4w07KBWp2Dyf
         xhwA==
X-Forwarded-Encrypted: i=1; AHgh+RoCeXY7ZB+tFcvPooprH0mn/GYRbYN4X00n/V9L/qd3Eb57Bc+UdjOvWO/fQ+GkC2gNjp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck0PVyeD3ED/IHo/WgMDBCbXQchd3eCSh1eQlPQK2SRlnkom8
	0MC31+qwOWWbHKWSIPtcZkyC1JpkTDqy/wdqE32XW7b38BtFVWSr40SHaznI1KaaSdK/9ktCsgm
	Iqssdvl3TaLI6pWiCyZFCP5vuNa2d2y20Skg=
X-Gm-Gg: AR+sD1200swKno/pJDEjQtg8hlFaRCfZ6HPz2Q+xtzseVfToW1tOMXnC+J+urAzLwNb
	+0ouCmglJj98zhDi3ansZQ1QINniwWh/mbWAybTUcxBEWYfwuee1BDvsqhzouJnKlDb0vr3cN0M
	G9SXWKrNpqKSlpHBfX0bwQ7QFZdXmDCkGGnc++/gzT6NOJG8j9az470KrDYJl/0NCrUbT3sbpTR
	fDziqlikElRb97ZgMosf/ExfeHwFEt89ZnY6xAUmoIuRdPPHGXHvarZFYyB0m4S6Vq3JvT7QmNM
	axfpeD318oNbw7sdgMyo0mQPDqQ/TQr93FDgzbMqHScWMqVhn/AwmfZAPku5aGr1d1ekPYU7
X-Received: by 2002:a17:907:9455:b0:c15:ce72:935e with SMTP id
 a640c23a62f3a-c1f71d7a48dmr204907366b.17.1785265469836; Tue, 28 Jul 2026
 12:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 29 Jul 2026 04:04:17 +0900
X-Gm-Features: AUfX_mxJJhLv5diWJuX6TiQ6lduJOcthNv0biaHCaSTCMAugyGy8Ps_oJHT9MKo
Message-ID: <CAGEsz8F60gmDxhvqiNib1h3=SoTMi_Uuz4PYOa8DrukHQaTK5w@mail.gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Hold KVM reference for HPT resize work
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

KVM_PPC_RESIZE_HPT_PREPARE schedules resize_hpt_prepare_work() with a
raw pointer to the enclosing KVM object. Book3S-HV VM destruction does
not wait for this work, so the worker can access struct kvm after
kvm_destroy_vm() has freed it.

A later prepare request with a different shift can also replace
kvm->arch.resize_hpt while the previous work remains busy. Such detached
work still retains its raw KVM pointer.

A pseries hash guest can initiate the work with H_RESIZE_HPT_PREPARE.
QEMU handles KVM_EXIT_PAPR_HCALL by issuing the prepare ioctl, and the
guest can then request RTAS power-off to initiate VM teardown. For a
4 GiB guest, QEMU permits shift=26, which makes the unlocked allocation
interval long enough to reproduce the race without instrumentation.

On unmodified upstream master 62cc90241548, the first shift=26
iteration produced:

BUG: KASAN: slab-use-after-free in mutex_lock+0x44/0xf0
Write of size 8 at addr c000000006330c18 by task kworker/0:1/10

Workqueue: events resize_hpt_prepare_work
mutex_lock
resize_hpt_prepare_work
process_one_work
worker_thread

The KVM object was freed concurrently by:

kvm_destroy_vm
kvm_vm_release
__fput
sys_close

Hold a KVM reference for every scheduled resize work and release it only
after the callback has stopped accessing the KVM. This covers both the
current resize and busy work detached by a replacement request. Once all
workers have dropped their references, VM destruction can safely release
the completed current resize object.

With this patch, KASAN reported no error in 10 shift=26-to-18 replacement
iterations, 1,000 shift=18-to-19 replacement iterations, or a
deterministic run that paused both callbacks for one second across VM
close. A powerpc64le vmlinux build, git diff --check, and strict
checkpatch also passed.

Fixes: 5e9859699aba ("KVM: PPC: Book3S HV: Outline of KVM-HV HPT
resizing implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 18 +++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer and full KASAN trace have not been posted publicly and
are available on request.

diff --git a/arch/powerpc/include/asm/kvm_ppc.h
b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa4660..371268a794c3c 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -226,6 +226,7 @@ extern int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
                                           struct kvm_ppc_resize_hpt *rhpt);
 extern int kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
                                          struct kvm_ppc_resize_hpt *rhpt);
+void kvmppc_release_hpt_resize(struct kvm *kvm);

 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46c..7776d6bcb5c53 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1409,6 +1409,17 @@ static void resize_hpt_release(struct kvm *kvm,
struct kvm_resize_hpt *resize)
                kvm->arch.resize_hpt = NULL;
 }

+void kvmppc_release_hpt_resize(struct kvm *kvm)
+{
+       /*
+        * Each resize worker holds a KVM reference, so all workers have stopped
+        * accessing the KVM before VM teardown reaches this point.
+        */
+       mutex_lock(&kvm->arch.mmu_setup_lock);
+       resize_hpt_release(kvm, kvm->arch.resize_hpt);
+       mutex_unlock(&kvm->arch.mmu_setup_lock);
+}
+
 static void resize_hpt_prepare_work(struct work_struct *work)
 {
        struct kvm_resize_hpt *resize = container_of(work,
@@ -1417,8 +1428,10 @@ static void resize_hpt_prepare_work(struct
work_struct *work)
        struct kvm *kvm = resize->kvm;
        int err = 0;

-       if (WARN_ON(resize->error != -EBUSY))
+       if (WARN_ON(resize->error != -EBUSY)) {
+               kvm_put_kvm(kvm);
                return;
+       }

        mutex_lock(&kvm->arch.mmu_setup_lock);

@@ -1452,6 +1465,7 @@ static void resize_hpt_prepare_work(struct
work_struct *work)
                resize_hpt_release(kvm, resize);

        mutex_unlock(&kvm->arch.mmu_setup_lock);
+       kvm_put_kvm(kvm);
 }

 int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
@@ -1506,6 +1520,8 @@ int kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
        INIT_WORK(&resize->work, resize_hpt_prepare_work);
        kvm->arch.resize_hpt = resize;

+       /* Keep the KVM alive until the worker has finished accessing it. */
+       kvm_get_kvm(kvm);
        schedule_work(&resize->work);

        ret = 100; /* estimated time in ms */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3b..3425aa8b6a8ec 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5889,6 +5889,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
        if (!cpu_has_feature(CPU_FTR_ARCH_300))
                kvm_hv_vm_deactivated();

+       kvmppc_release_hpt_resize(kvm);
+
        kvmppc_free_vcores(kvm);


--
2.47.2
