Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28123375AB4;
	Wed, 11 Mar 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229801; cv=none; b=sHJXNF2Anr1yCQWoDK/UXrk5aweI/HxGvShEBltKEL+JkftgM6vjaQAgDZMPDmQRcxSndiTck3NbIbFcO+Y9+3HiJ4+eGj/P4nMTe/e8Y9OhplMW7UMFbmI9Ghp8wXMbxN7Dq7K1ln27/bmjeEskRNka6ulas+okNWd4wx5CWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229801; c=relaxed/simple;
	bh=+ZfJEsefVmIGUvY2UjiN6CWygPz6+FffB/Y5BvtA7dw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Tpl1eHWXRTHO2m6mbLFUfsMjF8AdaYCxYCto56bq+lSy+Ed3J1ORK4lzAvJQEVE2J95GSMiTrCxa7snWQaU/nc/xpa/wIpTL+UgfbyPsTMR4DU+SDSBvK36TUShz/jrHRZWq3Gauh83B6JTxN5RihoAEsKOcHnVhHHYxvoxc8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ag2KeWAf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ag2KeWAf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:Date:To:From
	:Subject:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=cAi+vQvauN2eRhd9yncXyqLymth5qbbdsBD30rMeagI=; b=Ag2KeWAfy9EvdBL9nhZKiP9Pgc
	Mm1viJ5xRrf/XOhm4MhXrONqkYj3oYszUQQKTSeAPZnb/vkm/iMsQbmHDbCo2ZFQQddgedJKEPmDz
	dAaVSjjjDb/9m1HhysKHfjAhZkYbzq2iuLIMglBhixnCvMkcl8rryrQd0UMnYeOev3qPuP6IV455b
	qCX1jtkXh+JgPART30DJMjur91zeX59K3yhwbDbwpONc0WV5kKapVrTs0Jp1O9E4v/QLQdN0/x8/u
	iDT2TmPz6fgBLtEQdmd8L5T9diwquXVMBgj0o1eHJoA5zS80vuJhrDdzvSEgmvwPbkmDZBayVjl85
	1kF/hE9Q==;
Received: from [149.13.74.10] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0I4Q-0000000GphT-2J2U;
	Wed, 11 Mar 2026 11:49:46 +0000
Message-ID: <c73bc1f22fbdbd88efb21cb80eccdd98d2ea531a.camel@infradead.org>
Subject: [PATCH v2] KVM: x86: Use gfn_to_pfn_cache for record_steal_time
From: David Woodhouse <dwmw2@infradead.org>
To: Carsten Stollmaier <stollmc@amazon.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Mar 2026 12:49:45 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-L5Z/AZ/RbgpWLcXCmWQd"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-L5Z/AZ/RbgpWLcXCmWQd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carsten Stollmaier <stollmc@amazon.com>

On vcpu_run, before entering the guest, the update of the steal time
information causes a page-fault if the page is not present. In our
scenario, this gets handled by do_user_addr_fault and successively
handle_userfault since we have the region registered to that.

handle_userfault uses TASK_INTERRUPTIBLE, so it is interruptible by
signals. do_user_addr_fault then busy-retries it if the pending signal
is non-fatal. This leads to contention of the mmap_lock.

This patch replaces the use of gfn_to_hva_cache with gfn_to_pfn_cache,
as gfn_to_pfn_cache ensures page presence for the memory access,
preventing the contention of the mmap_lock.

As an added bonus, this removes the last open-coded assembler access
to userspace from arch/x86/kvm/x86.c.

Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/x86.c              | 115 +++++++++++++++-----------------
 2 files changed, 54 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index ff07c45e3c73..5eb38976af58 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -958,7 +958,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache cache;
+		struct gfn_to_pfn_cache cache;
 	} st;
=20
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a03530795707..7cbef6dc3216 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3745,10 +3745,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb=
_flush_requests);
=20
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc =3D &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	u64 steal;
 	u32 version;
=20
@@ -3763,42 +3761,26 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
 	if (WARN_ON_ONCE(current->mm !=3D vcpu->kvm->mm))
 		return;
=20
-	slots =3D kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation !=3D ghc->generation ||
-		     gpa !=3D ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+	read_lock(&gpc->lock);
+	while (!kvm_gpc_check(gpc, sizeof(*st))) {
 		/* We rely on the fact that it fits in a single page. */
 		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
=20
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
-		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
+		read_unlock(&gpc->lock);
+
+		if (kvm_gpc_refresh(gpc, sizeof(*st)))
 			return;
+
+		read_lock(&gpc->lock);
 	}
=20
-	st =3D (struct kvm_steal_time __user *)ghc->hva;
+	st =3D (struct kvm_steal_time *)gpc->khva;
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
-		u8 st_preempted =3D 0;
-		int err =3D -EFAULT;
-
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		asm volatile("1: xchgb %0, %2\n"
-			     "xor %1, %1\n"
-			     "2:\n"
-			     _ASM_EXTABLE_UA(1b, 2b)
-			     : "+q" (st_preempted),
-			       "+&r" (err),
-			       "+m" (st->preempted));
-		if (err)
-			goto out;
-
-		user_access_end();
+		u8 st_preempted =3D xchg(&st->preempted, 0);
=20
 		vcpu->arch.st.preempted =3D 0;
=20
@@ -3806,39 +3788,32 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_vcpu_flush_tlb_guest(vcpu);
-
-		if (!user_access_begin(st, sizeof(*st)))
-			goto dirty;
 	} else {
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		unsafe_put_user(0, &st->preempted, out);
+		st->preempted =3D 0;
 		vcpu->arch.st.preempted =3D 0;
 	}
=20
-	unsafe_get_user(version, &st->version, out);
+	version =3D st->version;
 	if (version & 1)
 		version +=3D 1;  /* first time write, random junk */
=20
 	version +=3D 1;
-	unsafe_put_user(version, &st->version, out);
+	st->version =3D version;
=20
 	smp_wmb();
=20
-	unsafe_get_user(steal, &st->steal, out);
+	steal =3D st->steal;
 	steal +=3D current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
+	st->steal =3D steal;
=20
 	version +=3D 1;
-	unsafe_put_user(version, &st->version, out);
+	st->version =3D version;
+
+	kvm_gpc_mark_dirty_in_slot(gpc);
=20
- out:
-	user_access_end();
- dirty:
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	read_unlock(&gpc->lock);
 }
=20
 /*
@@ -4173,8 +4148,12 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
=20
 		vcpu->arch.st.msr_val =3D data;
=20
-		if (!(data & KVM_MSR_ENABLED))
-			break;
+		if (data & KVM_MSR_ENABLED) {
+			kvm_gpc_activate(&vcpu->arch.st.cache, data & ~KVM_MSR_ENABLED,
+					sizeof(struct kvm_steal_time));
+		} else {
+			kvm_gpc_deactivate(&vcpu->arch.st.cache);
+		}
=20
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
=20
@@ -5237,11 +5216,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int =
cpu)
=20
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc =3D &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
+	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	static const u8 preempted =3D KVM_VCPU_PREEMPTED;
-	gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	unsigned long flags;
=20
 	/*
 	 * The vCPU can be marked preempted if and only if the VM-Exit was on
@@ -5266,20 +5244,28 @@ static void kvm_steal_time_set_preempted(struct kvm=
_vcpu *vcpu)
 	if (unlikely(current->mm !=3D vcpu->kvm->mm))
 		return;
=20
-	slots =3D kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation !=3D ghc->generation ||
-		     gpa !=3D ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
-		return;
+	read_lock_irqsave(&gpc->lock, flags);
+	if (!kvm_gpc_check(gpc, sizeof(*st)))
+		goto out_unlock_gpc;
=20
-	st =3D (struct kvm_steal_time __user *)ghc->hva;
+	st =3D (struct kvm_steal_time *)gpc->khva;
 	BUILD_BUG_ON(sizeof(st->preempted) !=3D sizeof(preempted));
=20
-	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)))
-		vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
+	st->preempted =3D preempted;
+	vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
=20
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	kvm_gpc_mark_dirty_in_slot(gpc);
+
+out_unlock_gpc:
+	read_unlock_irqrestore(&gpc->lock, flags);
+}
+
+static void kvm_steal_time_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_gpc_deactivate(&vcpu->arch.st.cache);
+	vcpu->arch.st.preempted =3D 0;
+	vcpu->arch.st.msr_val =3D 0;
+	vcpu->arch.st.last_steal =3D 0;
 }
=20
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -12744,6 +12730,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
=20
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
=20
+	kvm_gpc_init(&vcpu->arch.st.cache, vcpu->kvm);
+
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	else
@@ -12851,6 +12839,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_mmu_unload(vcpu);
=20
+	kvm_steal_time_reset(vcpu);
+
 	kvmclock_reset(vcpu);
=20
 	for_each_possible_cpu(cpu)
@@ -12971,7 +12961,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool ini=
t_event)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val =3D 0;
 	vcpu->arch.apf.msr_int_val =3D 0;
-	vcpu->arch.st.msr_val =3D 0;
+
+	kvm_steal_time_reset(vcpu);
=20
 	kvmclock_reset(vcpu);
=20
--=20
2.51.0



--=-L5Z/AZ/RbgpWLcXCmWQd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxMTExNDk0
NVowLwYJKoZIhvcNAQkEMSIEIN31XcCrtLt1oVD4bbqkhX8EaRdBqrhIxRhJzRTZS+AuMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAbHVdBuWb8IoM
hFAwGVSr8NjVGJ35HH5QktlSgYV46uQ8ufGRsH9oqOmuuJOBMzvB3wm3ICUAwGnVLj+5n97ZcBM0
1f8yXqIWTb4VrElG+Dda08pSzkw6skq9E/m35KKSkv5ISPrWGciIs1sgikJn4zZKcOwFzhYfMI5k
PrKP0kKcSJbE3Igy1G1otmfGWeFbv3HNZqQoPbem7BT7Ne0LDOiG0xzVlcuKzhn49n8WarbX/Frk
7MDgqffQNzESQtZ4rH2dsWIftZ0V7VEQEWEUyf07gk/k/4FVUbeLcir6OWMYCFIJJHW60J6Bg4o4
k71EkcYXxHzHyJ6E4y+MgLIx/cy6GEkfFq8qMbTlQh8mUsmbDjqYqm2mrgJEWuFUPYMHLy7LV+W0
Kur32wqnfGfKrjqGPXfDUVEDzpk2odAI2ZDQ7wv7cZfkZ/SOvBeeXN8RO0ItQPl4USyEL6bJc/l1
RMsHXs3juJ0wsHTl9/pdVrs2v0pNV7r3SLP0qsxxktxuzFmWC5ss5JvclrQgbBwX4NlU5tNWs0cu
TG5EVt+NnvYrTG9I9RhptUMk4DGOAhgtN05sSAUb4AWfrT1PhqzBt6xlVHDbWXMXns0DA9LzK8el
vKuIQeY7CVbJuYSBJ8zs6Du8MPj5q2QgD9b1U27GJ1Rsu6ZGIclb/1s5z+tTbWYAAAAAAAA=


--=-L5Z/AZ/RbgpWLcXCmWQd--
