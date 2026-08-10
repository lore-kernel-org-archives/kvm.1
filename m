Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF83AE706
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395390; cv=none; b=t+vkvWtrUCOnX12xTMEAQweqiNaLaDJr7Bltn65OU8fKpcLIcJR3u9JQUGN08QlOCxedIqF0AqVD7bEL3DZoKLAK2ic3h9XdtU64xUhrSqvhnsN08CPOxbX6SE6APmIPxD+TrL2qspVMCzXvUXTUZHeDb0x28MPflQw0DAclM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395390; c=relaxed/simple;
	bh=gV3PXNtOPo2dzqJVberp/Nshsac9CmoYYB8G1uWRGMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MT9UG36bGlRyAyvTnmLxnij9yOxC1JEyvlp4mp0MMaog+EGGDBiCxFSv5CfNct/R4el7yaq63x8Up1+t0Udg+fW56LE7Xq1xrxcIP4Grv0+/uPBWC+UGWxZQQtuQvpW03+UgUl9mFMpG/wPiF6ikbpmdr/inixT7heGLbnRp8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNFSUFW+; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNFSUFW+"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2972957a12.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786395387; x=1787000187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCgbuv6Vd7zF2bZTNz0VWHu3WJNY8tSX432zegD8YdU=;
        b=bNFSUFW+Hwr1m2QoQQwTY3YLdMhY07wlQ2bWpfNlmdFRpWQnc/9ugInC3tOqzfMCju
         qRkuPEQU1eqU85C4yzJPYQPaGAS1NrW6s8oMOQkjf9LCNSed118JxqCZt92MV5fp4qVy
         ObWZnmkn+jj4R8IK8TJS1IHNyfzswodPXaxpdIzSe4cdl/ysXHSfo3z7DXfez+w/P4kW
         dWP4m2QDSle7h3cdAfJ+vkgb9jL2irTF3Zm69u9qOjGuzdMqF9wU4pTW+s2oYvycioJ6
         Gf1Ms5ppjgdu0N8nRrLJUTdn5RY3cc1yDhLdWVKydyYGg9Vgjfs5D6EY2FjrQANEoOMF
         I5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395387; x=1787000187;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCgbuv6Vd7zF2bZTNz0VWHu3WJNY8tSX432zegD8YdU=;
        b=bX7RGIKTx51d0aSqZHFQa/JaOO1jHimtwlwF3DLxi7/D9bIICXvCkI/NUlhe6bhIvt
         Q2YhVumnTn/BT2utkeY9dTj2LgvgpWmHPh+y4aNU2T9xHORRI3c4y9bxOaxnuYBHSuh2
         BW7xDQuLGPSkvCUcEpq4xNNoMNcexLooIlpWNYt2bSX/yFDlml9mO6NeeCSoSNm4w3bR
         IR1h9fJ9HAEZjupn+7kGDSZtnpAfu8P9dp/ghu7IelElkrjtoV124AQnJvBbpB63lTTW
         06PRwFmpkw/BvbTCZX9YKNR76OP0lxhnRKEqJFrh+tcVt+niszEeLZiShXJTCntJa1Et
         Z0jw==
X-Forwarded-Encrypted: i=1; AHgh+RpckRRmbnT5IAKrm7GHwKnxT1lKRaM3uAqfnCE4Fnr4ztpkSPDbem9WT2YNScnbDW1bhMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1k2zdI92ZwCIaDfynP4pqQH2yyjqxvwSNieUwd1eF82O31lkI
	g1R2jNMzJwK2Y3pR6V/Ylgr4YUW674eEv8tc39FdWGpiEPUkrmXChExJUlysVbfd86FSgg/iBVQ
	x8dbT7Q==
X-Received: from pgmc19.prod.google.com ([2002:a63:1c53:0:b0:c98:2639:852e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad1:b0:848:4d1a:9556
 with SMTP id d2e1a72fcca58-84f9c8f6a11mr4384666b3a.11.1786395387317; Mon, 10
 Aug 2026 13:56:27 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:26 -0700
In-Reply-To: <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-18-dwmw2@infradead.org>
 <anoOz2rZ02KFk1l-@google.com> <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
Message-ID: <ano6-gIZtqMfipiD@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, David Woodhouse wrote:
> On Mon, 2026-08-10 at 10:47 -0700, Sean Christopherson wrote:
> > =C2=A0
> > > But when the vCPUs merely have a different TSC *offset*, that's not a
> > > problem. The offset is applied to that vCPU's kvmclock->tsc_timestamp
> > > field, and it all comes out in the wash.
> >=20
> > It's not though?=C2=A0 The value stored in kvmclock->tsc_timestamp is p=
er-VM, not
> > per-vCPU, when using the master clock.=C2=A0 It's a little easier to se=
e once the
> > master clock TSC isn't shoved into host_tsc:
> >=20
> > 	do {
> > 		seq =3D read_seqcount_begin(&ka->pvclock_sc);
> > 		use_master_clock =3D ka->use_master_clock;
> > 		if (!use_master_clock)
> > 			continue;
> >=20
> > 		if (!kvm_get_time_and_clockread(&kernel_ns, &host_tsc)) {
> > 			use_master_clock =3D false;
> > 			continue;
> > 		}
> >=20
> > 		master_tsc =3D ka->master_cycle_now;
> > 		master_ns =3D ka->master_kernel_ns;
> > 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
> >=20
> > 	...
> >=20
> > 	if (use_master_clock) {
> > 		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, master_tsc);
> > 		hv_clock.system_time =3D master_ns + v->kvm->arch.kvmclock_offset;
> > 	} else {
> > 		hv_clock.tsc_timestamp =3D tsc_timestamp;
> > 		hv_clock.system_time =3D kernel_ns + v->kvm->arch.kvmclock_offset;
> > 	}
>=20
> Meh. I shall have to build a better test case for that one. Thanks.
>=20
> > To allow different offsets, KVM would need to track a per-vCPU offset t=
o the
> > master clock and apply that in kvm_guest_time_update() (and maybe other=
 places?).
> > Which is doable, but it's not clear to me why we'd want to support that=
 (though
> > I haven't fully processed the back half ot his series, so it's very pos=
sible I'm
> > missing something obvious).
>=20
> Because I want to reduce the number of cases where we have to fall back
> to non-masterclock mode. Especially the ones which are driven by
> *guests* rather than weird choices on the VMM's part.

But why though?  What is the harm to the host or guest?  E.g. does it make =
it more
difficult to accurately migrate the VM?  I'm not opposed to allowing master=
-clock
mode with diverging offsets, just trying to understand why it matters.

