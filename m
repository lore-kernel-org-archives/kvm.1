Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA9371CE4
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854924; cv=none; b=kN/iakJInLDU4yCuOlJ4aFcN2M4DgUd107oGGTjOFJcoTMDUFELE+uaidF8IQ+l3aX/gp8QNV8yIyB7EX2MeGBCw9yZZvj34fgcy/XJIK+BAmxKVYDL/gYkuOs3mRMPSN3cYOcNLbR1KP0UAR68n40KLlc23TQ+IK8EJQo1akiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854924; c=relaxed/simple;
	bh=wj96FLvK72m67pH3jNQ0C+1v/0ID0Ycr2wlTUU5TRzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvQBVaF+aYuyv7TAeo9sdUcAyB3oY55VX4uwB7oC641RiKOTiXMjch9UHUCPzUhOsYWv6TkdsB+Co3PyE/gth0e8tAdBadvYrTzwjn+R2k8TRpK39rtiQiOVN+0jyCPJw/Q5LzSJwZKaEDj9XwNS9AisfTYCs7QyitcFFxYsNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h/ymhbPy; arc=none smtp.client-ip=95.215.58.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/ymhbPy"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wj96FLvK72m67pH3jNQ0C+1v/0ID0Ycr2wlTUU5TRzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788854920; v=1; x=1789459720;
 b=h/ymhbPyLoeIJLovY7rdy8gC73u2vpGOx3bWLVFpQpWHrJaNxrYMyBODiycho4ICuSthoMYN
 DcJv7BxQzZP0YR8wGuaXxShSblf9Zy/wM0AI9yLg/hS/O5Hfz+f9HJGVCSPg+Dn89YTk8016eoO
 iCGaGGh0KvboK1oEYzOL1Oag=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 46f88bfa78731cad;
	Tue, 08 Sep 2026 08:08:40 +0000
X-Mizu-Trace-ID: 46f88bfa78731cad
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17358so10222e87.1
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 01:08:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxUJLilR+0yH6Mb6ogrdc3CyvQBs4NA+FuzU1n4a6d9pF0JgMPh/3s4zonLPeyvDA9rAeE=@vger.kernel.org
X-Gm-Message-State: AFuF++nYwTJTfY8bpaC2zs+MFhpLO3VJ59N3MLi24xdTxQu1mI6axlPs
	/MzTWc7x7M4J1FC/U4Q128ke16qnUAwpk1cKMIEivd8O6C7B4vix+0E//49WiQ17g3uTIraRmgB
	Hspx3cjO/x8xqyEFkgPJKe4HFRTkKsj2m07P7q6uw
X-Received: by 2002:a05:6512:6412:b0:5ae:b918:79d5 with SMTP id
 2adb3069b0e04-5b74d1658d8mr213819e87.2.1788854919259; Tue, 08 Sep 2026
 01:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
 <20260826-arm64-52bit-va-v1-1-14ec98211363@fujitsu.com> <CA+EHjTy6EH-d=O+dtRdWdTUkS0zkXeW=auxiK6N5Dc-yihrYRw@mail.gmail.com>
 <ap9oag87vZiuTVer@sm-arm-grace07>
In-Reply-To: <ap9oag87vZiuTVer@sm-arm-grace07>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 8 Sep 2026 09:08:03 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx+Dtt-v8_6g1Rj9vO6j_7zRwjxywjYUXbgUj+FfsV6Rg@mail.gmail.com>
X-Gm-Features: AcwNN1WmotBPGHexNMlSdHcPHTVxfo5f6HxmhkMWAF9Pb_2HyxTj1nidelDjEwA
Message-ID: <CA+EHjTx+Dtt-v8_6g1Rj9vO6j_7zRwjxywjYUXbgUj+FfsV6Rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: selftest: arm64: Support 5-level paging in stage
 1 translation table
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Takayuki Okamoto <tokamoto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Itaru,

On Tue, 8 Sept 2026 at 02:44, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
...
> > This changes what level means for the existing three-level modes:
> > level 0 used to return the top-level entry and now trips the assert,
> > level 1 used to return the leaf and now returns the top level. No
> > caller in tree asks for either of those two levels, and the new
> > numbering matches the architecture.
>
> Yes, as you checked this change won't break current tests, so if you
> have better comments I will replace it with yours.

The code comment reads fine. What's worth adding is a commit-message
note on the behavior change:

  For 3-level (64K) modes this renumbers the levels to match the
  architecture: level 0 is no longer valid, level 1 is the top entry.
  No in-tree caller passes those levels.

...

> Yes, I've dropped the _va_size() function and instead, expanded a bit
> as you suggested the aarch64_get_supported_page_sizes() to check if vcpu
> can address upto 52-bit VA space or not (48-bit max).

Sounds good. One thing for v2: 52-bit VA support is per-granule, so a
single 52-vs-48 result won't hold across granules.
ID_AA64MMFR2_EL1.VARange is the 64K indicator. 4K and 16K get 52-bit
VA from LPA2.

Cheers,
/fuad

> Thanks,
> Itaru.
> >
> > Cheers,
> > /fuad
> >
> >
> > > +{
> > > +       struct kvm_vcpu_init preferred_init = {};
> > > +       int kvm_fd, vm_fd, vcpu_fd, err;
> > > +       u64 val;
> > > +       u32 va_range;
> > > +       struct kvm_one_reg reg = {
> > > +               .id     = KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR2_EL1),
> > > +               .addr   = (u64)&val,
> > > +       };
> > > +
> > > +       kvm_fd = open_kvm_dev_path_or_exit();
> > > +       vm_fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, NULL);
> > > +       TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
> > > +
> > > +       vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
> > > +       TEST_ASSERT(vcpu_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu_fd));
> > > +
> > > +       err = ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
> > > +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_PREFERRED_TARGET, err));
> > > +
> > > +       err = ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
> > > +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_VCPU_INIT, err));
> > > +
> > > +       err = ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
> > > +       TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_GET_ONE_REG, err));
> > > +
> > > +       va_range = FIELD_GET(ID_AA64MMFR2_EL1_VARange, val);
> > > +
> > > +       close(vcpu_fd);
> > > +       close(vm_fd);
> > > +       close(kvm_fd);
> > > +
> > > +       return va_range >= ID_AA64MMFR2_EL1_VARange_52 ? 52 : 48;
> > > +}
> > > +
> > >  void aarch64_get_supported_page_sizes(u32 ipa, u32 *ipa4k,
> > >                                       u32 *ipa16k, u32 *ipa64k)
> > >  {
> > >
> > > --
> > > 2.43.0
> > >
