Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123425;
	b=gT3xXjFLFNN9iXobYn8RXSKLMqo7fEnPUczxA6FFtpQlheYyblTEjON08BMFwfh2JpgI
	 1OB8W7WDIPBt9cTef0cRzKV82mJH6JeGaqaO6tj4Rh9KuUUVN3QRUjcpz3iUGoTirFLm6
	 57SVOuM2jrI90P0D2/ggJOVKeyZLrbySSD+il21X9qT0Ui3v2DwHnPjNYUZ2zd/Yw4v9n
	 VIAWv7JvcHPkHkmuxdXdXz8fr3hgxtejTQSv8eudhv1XFgqNSU0jT+DW4cAGz0u+Jpoan
	 Mj2uDrH3YTfrU1PPlvNcEGwMHEo26OfqrnDBOn1jexsZOu4a6gnqkciJlosOJ5qskYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=u2t+BU6YM38qKUNb8LxM2rrX+fVNC6kao+NGos+aKQI=;
	b=YtLMOx/jkEPbUuJT5w2uYhf9Dh8pYoEXLGCxhQgGEz0Zxa+sDN2hmswj8v6bZ2rE01G4
	 0tSQPjMn83IxVPaFC1q7gyOY3imucbsKIgDqMdLHiv6SmGO5NG4AuAmfos626He+4LPgw
	 pFlnwu99ybdoRqd8EE9JGNKEmRKAq0Ip0S6+ALSRn93ijQ90BELJ1bpQBFGeMJyh08cD9
	 AmEQF5uOVlWUHT3J4NuTdG/eTtTAlNnSml5EMGIuHYJ2NpI0/LfHVGIefq1vu0e1TaSho
	 tur7Lv840d0J8omKWb5cUCOVa9ntl382Fnt0XzYSPM35LB27FHNvVtEZy5oaHlSbu/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fm7CQuyg;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303B606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3303B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fm7CQuyg
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05b68f851so1188017b3a.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123424; x=1793728224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u2t+BU6YM38qKUNb8LxM2rrX+fVNC6kao+NGos+aKQI=;
        b=fm7CQuyghppiS7nbiNxZWu4F8SHltKLvRa8uVkeZlo6ObkQaSp/St1X2tIOv9PHw+g
         NBfCHqvpIRIEFLjrlhjT+jINZbABPyxZGsVETn5DXVUsRU4feoYPe+iExs6Ebl8BvkP9
         SoNtIrXTABIWfj7Sd5rlh5KJ8edW6oLtOwFmQ8hiKULFrx6IoSafQoxtt5fl3r4r0GXX
         xxWteNGe9V0mxecAKUVGsn5gMRyzuQxj8rkpd97LDJ1X9KTAgT0KBLg/6WSNuHV+TpWI
         VCrgaKBOX/2Mipcw96RB0ZDlfIieytTc8LaUDeh5/bvmBKxZu1LGjJ1Khoc9GdnOlL7B
         R4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123424; x=1793728224;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2t+BU6YM38qKUNb8LxM2rrX+fVNC6kao+NGos+aKQI=;
        b=uLjnqfYWKTG19QUCw3PR46kk4UNk7L7kgq5zKb8gfGocSUP+i1C9j4Gj0Fv7fVP+8r
         ytnTdmd8BwZoetkM24OJy4J8tmIL6Dg0J8nVxaF6HJcagYK93hyOVEiIuQo0CTWgSstm
         gJ/Zpl0hTKUCysIU4dNucbcODvtAN4r1dC2G3njVNB8uH9gPChHxd1tEUoMMQiJqC9us
         t7pERH6ejYEr4cnz2lgd+AfoXPlZdoNISB1bw71nQFabWtMGiqUWSR1sqwIXsn8+mWHT
         9KSbPyC8wg1CvdVZWYsID8+WRTdUduS1F1oHOEEgDw/K7OpKB5CZHyfKjKznMvFcdfF6
         IS3g==
X-Forwarded-Encrypted: i=1; AKwUvBzeod3FfKdAOnvw2lq058EdzTMTR4XmfMW+P2HGxzZI28xITTte3PgkfDn7w7zMudCh1F0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXc3u0d+iD0ya3Z7zmWHDfve5KZFv6Kz9tPKPmwg/38jvnFP91
	/f26vz8WSlhQ9mpmk5ZsYA1Zwr43ZhZ5Jrzsf+WggLfPPhUNiuYvAEgrMvWDxI9QUk/CVHfIIkF
	41KJnFA==
X-Received: from pgca11-n1.prod.google.com ([2002:a05:6a02:638b:10b0:cd8:c70b:ae89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9190:b0:3e1:37c9:5ca2
 with SMTP id adf61e73a8af0-3e8ead1c6eemr2057958637.19.1793123424278; Tue, 27
 Oct 2026 10:50:24 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:50:23 -0700
In-Reply-To: <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
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
Message-ID: <auDkX94UTjrLNmqp@google.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026, Yosry Ahmed wrote:
> On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel=
.org> wrote:
> > > > > Moreover, does this change the semantics of PV TLB flush? In
> > > > > record_steal_time(), we have:
> > > > >
> > > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > > >
> > > > > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. =
In
> > > > > the past, with a shared ASID, L1's ASID was always flushed on emu=
lated
> > > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't=
 find
> > > > > any real documentation on PV TLB flush, it *seems* like the remot=
e
> > > > > vCPU would want L1's ASID to be flushed. OTOH, this change makes =
nSVM
> > > > > behave just like nVMX.
> > > >
> > > > That's a bug that absolutely needs to be fixed, probably relatively=
 urgently.  We
> > > > should also document that passing through the steal_time shared inf=
ormation to L2
> > > > to utilize PV TLB flushes for L2 is explicitly not supported.
> > > >
> > > > I hate to re-introduce deferred actions for L2 =3D> L1 things, but =
that seems like
> > > > the only sane way to handle this, because handling the !tdp_enabled=
 case, where
> > > > KVM needs to sync the current root, requires knowing what MMU is go=
ing to be in
> > > > use when L1 regains control.  Yuck.
> > >
> > > Are you implying that *you* will be re-introducing deferred actions? =
:P
> >
> > Heh, probably not this calendar year.
>=20
> Are you opposed to this series landing before that is fixed, keeping
> in mind that it will expose nSVM to the pre-existing bug?

Nah, though I should just fix the damn bug.  It's not hard, I just don't wa=
nt to
do it because I don't want to reintroduce a deferred request.  Untested, bu=
t I
think this is all that's needed.

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 0378577d9d8b..696aae38f619 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -879,6 +879,7 @@ struct kvm_vcpu_arch {
=20
 	struct {
 		u8 preempted;
+		bool flush_tlb_pending;
 		u64 msr_val;
 		u64 last_steal;
 		struct gfn_to_hva_cache cache;
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..efa54f9f9e9a 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -469,6 +469,11 @@ static inline void leave_guest_mode(struct kvm_vcpu *v=
cpu)
 		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
 	}
=20
+	if (vcpu->arch.st.flush_tlb_pending) {
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+		vcpu->arch.st.flush_tlb_pending =3D false;
+	}
+
 	vcpu->stat.guest_mode =3D 0;
 }
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..15eb033b8e17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2117,8 +2117,12 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
=20
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
-		if (st_preempted & KVM_VCPU_FLUSH_TLB)
-			kvm_vcpu_flush_tlb_guest(vcpu);
+		if (st_preempted & KVM_VCPU_FLUSH_TLB) {
+			if (!is_guest_mode(vcpu))
+				kvm_vcpu_flush_tlb_guest(vcpu);
+			else
+				vcpu->arch.st.flush_tlb_pending =3D true;
+		}
=20
 		if (!user_access_begin(st, sizeof(*st)))
 			goto dirty;
