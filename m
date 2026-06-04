Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3A21FF23
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578937; cv=none; b=YU47qGWz3nrAo/xPVi+QKrwHf8mrMHhWbtGz1P0/XAHoSr5f7uisRN+m54NOUGSEelR1iKFAeTmugp5p5384kLaHuNT6tIn7fumRam3gcAAOcNX/JrSvl/3rN7+suhpDQyqRWaR2Ls1B5Wf+XVERlAX+fBI/310P+QApf+dMeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578937; c=relaxed/simple;
	bh=QieyrWiaSepel6Tiv6cUmXXX5ljp6ON/0vZCvVrD/oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASVtzf5bTYWudCiEM+KL56v/Gt8db7DXAdwVe+mSbQZJr0k47F8enoXiBX14ptqlMpsiKAERR69gxlG1/tZI+3w08vgskjohXNvkYtUZFgMA5ci7kKewlYRHYkofAIW1/kFqrIcID9Ys27RS8D9HUh3fRtzAmsVvD5dnvbOBGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niOiIngT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niOiIngT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso7552725ad.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780578936; x=1781183736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grR5bBmlRncKWInq3qoDqJlCrA+AMKtJe+3XWrNLDf8=;
        b=niOiIngTSBaf02dvqG68v/8pwx0FjLBKNbRX/nJgipYx0Rzyvh9ZuzkcuL7Nu0qyJA
         jNWY+uThuQi0mgpkfOnIM/rMk44d8a68RGLUPANidjvb/0wnUl8B5lFCpjht/RQ94JQy
         qFskO7W8Amwu9yvEUPUqZIuhi7XiqpLd4xlk2Pc/faLdWocJpgI3cCrbkA87m0oGYLVR
         B8TaqvNnF79kBH2GQm8AkfhVVnFNOOCT0f98LIkPAaKNOJVcuI1B+mDo4igwwaFrxX34
         W9vr30oh3g7bXhvj+JX6ISSgKFVQrmtSSfzsj6HIvzA75Nrl1URlWXYel1aao1Thqmp0
         TYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578936; x=1781183736;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grR5bBmlRncKWInq3qoDqJlCrA+AMKtJe+3XWrNLDf8=;
        b=FUnYvz6qPt780iKzx8LYM9g2Nc8uZh5GNcYo9rw3Zk44DhMBRB7QeS6sro3hJvTGGo
         PUEDF/nLDoer4kGL6PTxTG6KzTuVaOuR7XeOn6/PhOXp+7mf48tOXfcyJvM9RrJ/bzC9
         HK2FhQcXQTnIXiCYvfFrX5VVUz7/U8rFP2H9e3HY5fN9h2tsj4RzhKshlkBXDerJHtR3
         rVAMuF+U2FEYQvxrDcRlfg/sWp7G435tL4anVkw1R0GkRGWTFy5/zJIIEkq0gEPjSEKt
         FAFoG8XyebIrAoNJ7m/boYarBsgrMdLLALrf1htI1W+O3Sx2MKacxOsjc9zFTC2v7IPP
         LdqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0g9WkEqVRMgnFlTUrv72DthkLvCH9N2lo6nIVt4F9oVwN69Odnh8++tlgHqkYiwnv9so=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1g2mbh1QIJUlBnGISBcVvWnXR05LMXCQN1H7Njrl6ztXG28g
	RaYLqlNpUtfKZoD7/2pZbZcQm+ThgcUJmX1lHHADd7SdM9ukMtd9daZDaVaDVvqw4P/dSP2YTTP
	pZLdmoA==
X-Received: from plxd13.prod.google.com ([2002:a17:902:ef0d:b0:2ba:36eb:2f7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d592:b0:2c0:f807:56b2
 with SMTP id d9443c01a7336-2c1644ca2f2mr81291685ad.34.1780578935477; Thu, 04
 Jun 2026 06:15:35 -0700 (PDT)
Date: Thu, 4 Jun 2026 06:15:34 -0700
In-Reply-To: <CALMp9eT2mBWgX9VntLJcRYDCeMdLzZwzmPbHrbcM6CRL2tYT0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603223418.1720035-1-seanjc@google.com> <CALMp9eT2mBWgX9VntLJcRYDCeMdLzZwzmPbHrbcM6CRL2tYT0g@mail.gmail.com>
Message-ID: <aiF6dg4_9mA-ID-5@google.com>
Subject: Re: [PATCH 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with
 guest CR3
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026, Jim Mattson wrote:
> On Wed, Jun 3, 2026 at 3:34=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Fix two bugs where KVM can run L2 with a guest-controlled CR3.  The und=
erlying
> > flaw dates back to commit f087a02941fe ("KVM: nVMX: Stash L1's CR3 in
> > vmcs01.GUEST_CR3 on nested entry w/o EPT").  Past me claimed:
> >
> >   Smashing vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the un=
wind,
> >   reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be overwritte=
n with
> >   a shadow CR3 prior to re-entering L1.
> >
> > which was and is true, _if_ a nested VM-Exit or the unwind is reached. =
 If KVM
> > fails directly, vmcs01.GUEST_CR3 will be left pointing at L1's actual C=
R3, i.e.
> > KVM will run with legacy shadow paging a guest-controlled CR3, which is=
... not
> > good.
> >
> > Note, the vTPR fix will cause KVM-Unit-Test's TPR Threshold test to fai=
l when
> > run with warn_on_missed_cc=3D1:
> >
> >   FAIL: Use TPR shadow enabled: virtual-APIC address =3D 8000000: vmlau=
nch succeeds
> >   FAIL: Use TPR shadow enabled: virtual-APIC address =3D 10000000: vmla=
unch succeeds
> >   ...
> >   FAIL: Use TPR shadow enabled: virtual-APIC address =3D ffffffffff000:=
 vmlaunch succeeds
> >
> > due to KVM actually accessing the virtual APIC page.  Given that I'm pr=
etty
> > sure I'm the only person that runs with warn_on_missed_cc=3D1, and that=
 IMO this
> > is firmly a test bug (e.g. on bare metal I'm pretty sure there's guaran=
tee
> > VMLAUNCH will succeed), I don't see any reason to try and make it "work=
" in
> > KVM.  I might try to figure out a way to make the KUT testcase play nic=
e, but
> > for now I'll just ignore the failures in my test runs.
>=20
> IIRC, the tests in question are confirming PCI bus error semantics.
> Why would the VMLAUNCH not succeed on bare metal?

Well, I was assuming it would fail because it couldn't actually guarantee P=
CI Bus
Errors, as it could very well stumble into actual device memory.  But the t=
est
leaves TPR_THRESHOLD as '0', and so regardless of what value the CPU gets b=
ack,
consistency check will still pass.

But!  I'm pretty sure the test would generate #MCs, not PCI bus errors.  Th=
e
SDM very, very strongly implies that the reads will use WB:

  Bits 53:50 report the memory type that should be used for the VMCS, for
  data structures referenced by pointers in the VMCS (I/O bitmaps,
  virtual-APIC page, MSR areas for VMX transitions), and for the MSEG heade=
r.
  ^^^^^^^^^^^^^^^^^

  If software needs to access these data structures (e.g., to modify the
  contents of the MSR bitmaps), it can configure the paging structures to m=
ap
  them into the linear-address space. If it does so, it should establish
  mappings that use the memory type reported bits 53:50 in this MSR.

  As of this writing, all processors that support VMX operation indicate th=
e=20
  write-back type. The values used are given in Table A-1.

And _that_ will definitely cause problems, especially if the read hits devi=
ce
memory.

That said, KVM's de facto ABI is that VMX instructions get PCI Bus Error se=
mantics
on accesses KVM can't handle, and it's just as easy to skip the consistency=
 check.
Since a read of 0xff guarantees the vTPR >=3D TPR_THRESHOLD, the check will=
 pass
regardless of TPR_THRESHOLD.

So, other than my stubbornness :-D, there's no reason to deliberately fail =
the
check if KVM can't read memory.  I'll go with this for v2:

	gpa_t vtpr_gpa =3D vmcs12->virtual_apic_page_addr + APIC_TASKPRI;
	u32 vtpr;

	if (!nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
		return 0;

	if (CC(!page_address_valid(vcpu, vmcs12->virtual_apic_page_addr)))
		return -EINVAL;

	if (CC(!nested_cpu_has_vid(vmcs12) && vmcs12->tpr_threshold >> 4))
		return -EINVAL;

	/*
	 * Do the illegal vTPR vs. TPR Threshold consistency check if and only
	 * if KVM is configured to WARN on missed consistency checks, otherwise
	 * it's a waste of time.  KVM needs to rely on hardware to fully detect
	 * an illegal combination due to the vTPR being writable by L1 at all
	 * times (it's an in-memory value, not a VMCS field).  I.e. even if the
	 * check passes now, it might fail at the actual VM-Enter.
	 *
	 * If reading guest memory fails, skip the check as KVM's de facto ABI
	 * for VMX instruction accesses to non-existent memory is to provide
	 * PCI Bus Error semantics (reads return 0xFFs), in which case the vTPR
	 * is guaranteed to greater than or equal to the threshold.
	 *
	 * Note!  Deliberately use the VM-scoped API when reading guest memory,
	 * to ensure the read doesn't hit SMRAM when restoring L2 state on RSM,
	 * and only perform the check when in KVM_RUN, to avoid a false failure
	 * if userspace hasn't yet configured memslots during state restore.
	 */
	if (warn_on_missed_cc && vcpu->wants_to_run &&
	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
	    !nested_cpu_has_vid(vmcs12) &&
	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
	    !kvm_read_guest(vcpu->kvm, vtpr_gpa, &vtpr, sizeof(vtpr)) &&
	    CC((vmcs12->tpr_threshold & GENMASK(3, 0)) > ((vtpr >> 4) & GENMASK(3,=
 0))))
		return -EINVAL;

	return 0;
