Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921509;
	b=tpEukWfCSPNpEPBx5fbGNGqjRHs59IoygOMB1G/qjE5F9i+/9fnmnyDm58UTohRYM9oi
	 3N4o4Uoh5GN9PHjUgr/xm/1ZfaEod3td2/L3nAJFGKoPlL4Ntl1VPdhmZRldjVUzMfsL5
	 QK9/XdRkvb8a/enxsPc+FgXJ+UZ1aBhsP7qelC3slPpxIuTGe10iq3+gH3VWr9+shS4/Z
	 zkzAhWr0+FS2phqcnj9VD/lJpiI2t2nbqR1iXyRAQlu7dQwHGCQ8t6rPRot7blGFzLx0p
	 kJy9+8u/HGABe1h6KbCxWNch43o2hyUkQrZcGqmUgtW0mSchGNAQkkDaqNmsBL3bljQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=NaAxVjpBNB4pKTylgaHtCm3wXm5bPQvdxMeR5CSoqlU=;
	b=s1fq0IinYhBHKnMqjXT1kiIg28bpyFpoaZ3jQrH2JfOF3F0lOcWJxxE0XYWxx3wRZXb5
	 yNxANJjwdB6oVd0TLsMXI0nrQ1gdVLssl8ydxdRs0Hv3gAnzwYenKEUcA5jURKp7zOY3j
	 A0b+psDxECZRYT5T7733AoWDBi6ddP5syiQmBak7i9FoAciWEcDRon8WcA36iJk1AQA2Q
	 WqWrhMQcByL3jATl/XIm7XKmMzVl8InbKSXF9ycGWLdGPjMY3OmxeClX92Lf1lKH0qDOn
	 5sQ+5mlRCjQZSrRRv6IlNV0SbqkT95jv15vNczZxsaIavLnucJNgCSU5nuCKuqGbY0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X32tjmfW;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40A606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE40A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X32tjmfW
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so62572a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793921508; x=1794526308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NaAxVjpBNB4pKTylgaHtCm3wXm5bPQvdxMeR5CSoqlU=;
        b=X32tjmfW8Vfe1XC1TL3TN70ZNal1Lhp4TAtbk1rJMMIYYcxSfJfk2hUCuC8bhVMyjd
         YXIbsBeECAi5pPsC6SIg5QLaC9h22P1famYcbx+qGPnBhLyGF4t+fyYwO1iaF7a1URoT
         +IVw3GUTc8jXJqDHgEKvgnjh2zjTLGgoTK4iL3+FyivLjF6nvI4c3kzaXtIV8yLZsJH3
         pngpWC0CA+ecx667fn6K9/qaw/cCnD0rm49T2WZxxSlRIrX90X1Ut6svhs04nfuJf51p
         F9yQJ6N0fcvYTaZJWiVPalMKeuzQs6rmmdABnk/rhdtGmtN+Esq2Dp4H/ghj7Zzk4wOa
         tMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921508; x=1794526308;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaAxVjpBNB4pKTylgaHtCm3wXm5bPQvdxMeR5CSoqlU=;
        b=oxcpbbT7gv3uoQSXRqxraq8BvVeUhsGa87L2hk4/q9Ta2jhu1H9iRrVESbQZz6luwj
         WtKD/yPe41Y2xZjbAaRiKvmfIge7ve2BNVQXQQiQd4xKeQpZOKrdzPUEYcm+rBCdWwVt
         Gld/VkiMYG5PAYtrM7bbrOul+Ypmhf+5frMbH2/gXyzBh+b656/cGDRQSD3U2WjFg4eb
         BbwyzgfuT64tBJN+tzH/ynzVg69RXPm3VnAzOutaj0Eo7Vr7HCuKuUxmDBN4Yx3FCeT2
         mwcj2aa932RfMVsebbq+dcKqQH1sEoTE14KP76pDl/kLMP7FJkmv1p/2e0RESPE3HnSM
         NVpQ==
X-Forwarded-Encrypted: i=1; AKwUvByiefu1dBvx3V0ZG7Y7kNEiYQz7jjCO0eTHvvu29dkYKOxyy58GIx7auHGoQQleXuBbSvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8frp91+GwQQ+BA1M0MLM6sts/3tGrVV0KQHSFCZL+sC46d9WEL
	DKZM9FJbjLrgsCRCGm9E/SlhFYLuXjeek971z6/+wkF0E7QDVtPcIbcA1UzWwFqyf52l53nSVwL
	N5dWVPg==
X-Received: from pjao9.prod.google.com ([2002:a17:90a:1689:b0:3ab:3d7f:6c0c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3944:b0:3ab:2c2b:1026
 with SMTP id 98e67ed59e1d1-3b0db6d1ac9mr578834a91.34.1793921508002; Thu, 05
 Nov 2026 15:31:48 -0800 (PST)
Date: Thu, 5 Nov 2026 15:31:47 -0800
In-Reply-To: <auDkX94UTjrLNmqp@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atqRyeqSXViiNIk6@google.com> <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
 <at-O8-tzgezj2du-@google.com> <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
 <auDkX94UTjrLNmqp@google.com>
Message-ID: <au0R41xbEJ_9W_9z@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026, Sean Christopherson wrote:
> On Mon, Oct 26, 2026, Yosry Ahmed wrote:
> > On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > > > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kern=
el.org> wrote:
> > > > > > Moreover, does this change the semantics of PV TLB flush? In
> > > > > > record_steal_time(), we have:
> > > > > >
> > > > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > > > >
> > > > > > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID=
. In
> > > > > > the past, with a shared ASID, L1's ASID was always flushed on e=
mulated
> > > > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can=
't find
> > > > > > any real documentation on PV TLB flush, it *seems* like the rem=
ote
> > > > > > vCPU would want L1's ASID to be flushed. OTOH, this change make=
s nSVM
> > > > > > behave just like nVMX.
> > > > >
> > > > > That's a bug that absolutely needs to be fixed, probably relative=
ly urgently.  We
> > > > > should also document that passing through the steal_time shared i=
nformation to L2
> > > > > to utilize PV TLB flushes for L2 is explicitly not supported.
> > > > >
> > > > > I hate to re-introduce deferred actions for L2 =3D> L1 things, bu=
t that seems like
> > > > > the only sane way to handle this, because handling the !tdp_enabl=
ed case, where
> > > > > KVM needs to sync the current root, requires knowing what MMU is =
going to be in
> > > > > use when L1 regains control.  Yuck.
> > > >
> > > > Are you implying that *you* will be re-introducing deferred actions=
? :P
> > >
> > > Heh, probably not this calendar year.
> >=20
> > Are you opposed to this series landing before that is fixed, keeping
> > in mind that it will expose nSVM to the pre-existing bug?
>=20
> Nah, though I should just fix the damn bug.  It's not hard, I just don't =
want to
> do it because I don't want to reintroduce a deferred request.  Untested, =
but I
> think this is all that's needed.

Early warning, so that you don't post a new version of the series and then =
have
to respin again.  I'm planning on posting a fix that plumbs an @l1_pv_flush=
 flag
around instead of deferring the fix.  I realized that KVM synchronizes *all=
* MMUs
for the !tdp_enabled case, which means that all flushing immediately is ove=
rall
less risky than deferring the flush (and obviously I was looking for any ex=
cuse
to not re-introduce deferred actions).

I peeked at the rest of this series, and AFAICT it won't throw too big of a=
 wrench
in things.

---
KVM: x86: Always target L1 when handling steal-time PV TLB flushes

Explicitly target L1 when handling steal-time based PV TLB flushes, as
KVM's undocumented ABI for its PV features is that they are scoped to L1,
e.g. KVM hypercalls from L2 are routed to L1 or rejected with a #UD.

Route a flag through all the flush_tlb_guest() paths to basically ignore
is_guest_mode() as appropriate.  Note!  KVM synchronizes all MMUs, past
and present, when servicing a guest TLB flush, i.e. there is no need to
switch from targeting L2 to targeting L1 for that specific flow.

Alternatively, KVM could defer PV TLB flushes until L1 is active, but the
correctness of waiting to synchronize MMUs when TDP is disabled is dubious,
as KVM has historically synchronized *all* MMUs for the vCPU.  And from the
guest's perspective (other vCPUs), KVM has communicated the the flush has
already occurred.  And in general, KVM has moved away from deferred L2=3D>L=
1
actions, precisely because of similar edge cases.

Fixes: 2b4a5a5d5688 ("KVM: nVMX: Flush current VPID (L1 vs. L2) for KVM_REQ=
_TLB_FLUSH_GUEST")
Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN=
0ESi00b_uq=3DA@mail.gmail.com
Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 0378577d9d8b..51bb66d1618a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1598,7 +1598,7 @@ struct kvm_x86_ops {
 	 * Flush any TLB entries created by the guest.  Like tlb_flush_gva(),
 	 * does not need to flush GPA->HPA mappings.
 	 */
-	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu);
+	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu, bool l1_pv_flush);
=20
 	bool (*vcpu_needs_initialization)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 622a6553e9ac..3ece27d34398 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -312,14 +312,16 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_=
hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
=20
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
+static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu,
+					       bool l1_pv_flush)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
=20
 	if (!kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
=20
-	tlb_flush_fifo =3D kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	tlb_flush_fifo =3D kvm_hv_get_tlb_flush_fifo(vcpu, !l1_pv_flush &&
+							 is_guest_mode(vcpu));
 	if (!tlb_flush_fifo)
 		return;
=20
@@ -396,7 +398,7 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcp=
u)
 {
 	return HV_STATUS_ACCESS_DENIED;
 }
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu, bool=
 l1_pv_flush) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vect=
or)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 581bc3a23c95..f045dc010027 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4304,7 +4304,7 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vc=
pu)
 	svm->vmcb->save.rflags |=3D (X86_EFLAGS_TF | X86_EFLAGS_RF);
 }
=20
-static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
+static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu, bool l1_pv_flush)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
@@ -4313,14 +4313,14 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcp=
u)
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
 	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_vcpu_purge_flush_tlb(vcpu, l1_pv_flush);
=20
 	/*
 	 * Flush only the current ASID even if the TLB flush was invoked via
-	 * kvm_flush_remote_tlbs().  Although flushing remote TLBs requires all
-	 * ASIDs to be flushed, KVM uses a single ASID for L1 and L2, and
-	 * unconditionally does a TLB flush on both nested VM-Enter and nested
-	 * VM-Exit (via kvm_mmu_reset_context()).
+	 * kvm_flush_remote_tlbs() or is a PV TLB flush targeting L1.  Although
+	 * flushing remote TLBs requires all ASIDs to be flushed, KVM uses a
+	 * single ASID for L1 and L2, and unconditionally does a TLB flush on
+	 * both nested VM-Enter and nested VM-Exit (via kvm_mmu_reset_context()).
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
 		svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
@@ -4341,7 +4341,7 @@ static void svm_flush_tlb_current(struct kvm_vcpu *vc=
pu)
 	if (svm_hv_is_enlightened_tlb_enabled(vcpu) && VALID_PAGE(root_tdp))
 		hyperv_flush_guest_mapping(root_tdp);
=20
-	svm_flush_tlb_asid(vcpu);
+	svm_flush_tlb_asid(vcpu, false);
 }
=20
 static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
@@ -4356,14 +4356,14 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu=
)
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
 		hv_flush_remote_tlbs(vcpu->kvm);
=20
-	svm_flush_tlb_asid(vcpu);
+	svm_flush_tlb_asid(vcpu, false);
 }
=20
-static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
+static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu, bool l1_pv_flush)
 {
 	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
=20
-	svm_flush_tlb_asid(vcpu);
+	svm_flush_tlb_asid(vcpu, l1_pv_flush);
 }
=20
 static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
@@ -4381,7 +4381,7 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, =
gva_t gva)
 		return;
 	}
=20
-	svm_flush_tlb_guest(vcpu);
+	svm_flush_tlb_guest(vcpu, false);
 }
=20
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..c2b5c04cd2b8 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -547,12 +547,12 @@ static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, g=
va_t addr)
 	vmx_flush_tlb_gva(vcpu, addr);
 }
=20
-static void vt_flush_tlb_guest(struct kvm_vcpu *vcpu)
+static void vt_flush_tlb_guest(struct kvm_vcpu *vcpu, bool l1_pv_flush)
 {
 	if (is_td_vcpu(vcpu))
 		return;
=20
-	vmx_flush_tlb_guest(vcpu);
+	vmx_flush_tlb_guest(vcpu, l1_pv_flush);
 }
=20
 static void vt_inject_nmi(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..e6a61514e797 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3398,7 +3398,7 @@ void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t a=
ddr)
 	vpid_sync_vcpu_addr(vmx_get_current_vpid(vcpu), addr);
 }
=20
-void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
+void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu, bool l1_pv_flush)
 {
 	/*
 	 * vpid_sync_context() is a nop if vpid=3D=3D0, e.g. if enable_vpid=3D=3D=
0 or a
@@ -3407,7 +3407,10 @@ void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	 * disabled (VM-Enter with vpid enabled and vpid=3D=3D0 is disallowed),
 	 * i.e. no explicit INVVPID is necessary.
 	 */
-	vpid_sync_context(vmx_get_current_vpid(vcpu));
+	if (l1_pv_flush)
+		vpid_sync_context(to_vmx(vcpu)->vpid);
+	else
+		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
=20
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cd72684d075d..67e5dd728267 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -82,7 +82,7 @@ bool vmx_get_if_flag(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_all(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_current(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr);
-void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu);
+void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu, bool l1_pv_flush);
 void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
 u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
 void vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..3bbd15b64e99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2009,7 +2009,7 @@ static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *v=
cpu)
 	kvm_clear_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
=20
-static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
+static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu, bool l1_pv_flu=
sh)
 {
 	++vcpu->stat.tlb_flush;
=20
@@ -2024,13 +2024,13 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcp=
u *vcpu)
 		kvm_mmu_sync_prev_roots(vcpu);
 	}
=20
-	kvm_x86_call(flush_tlb_guest)(vcpu);
+	kvm_x86_call(flush_tlb_guest)(vcpu, l1_pv_flush);
=20
 	/*
 	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
 	 * grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_vcpu_purge_flush_tlb(vcpu, l1_pv_flush);
 }
=20
=20
@@ -2052,7 +2052,7 @@ void kvm_service_local_tlb_flush_requests(struct kvm_=
vcpu *vcpu)
 		kvm_vcpu_flush_tlb_current(vcpu);
=20
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu))
-		kvm_vcpu_flush_tlb_guest(vcpu);
+		kvm_vcpu_flush_tlb_guest(vcpu, false);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
=20
@@ -2118,7 +2118,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
-			kvm_vcpu_flush_tlb_guest(vcpu);
+			kvm_vcpu_flush_tlb_guest(vcpu, true);
=20
 		if (!user_access_begin(st, sizeof(*st)))
 			goto dirty;
@@ -8193,7 +8193,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_KVM_HYPERV
 		if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu) &&
 		    kvm_hv_vcpu_flush_tlb(vcpu))
-			kvm_vcpu_flush_tlb_guest(vcpu);
+			kvm_vcpu_flush_tlb_guest(vcpu, false);
 #endif
=20
 		if (kvm_check_request(KVM_REQ_REPORT_TPR_ACCESS, vcpu)) {

