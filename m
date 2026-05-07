Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580D1E5714
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114474; cv=pass; b=ksRlHFujvrBdmrayPd6WlE4GNymvZNpYQfy/S3dCgBQcguDQA4a2aDG8iWuRYAqgr3ofqmjOgy+ZvumglnJhgmd7EIC53G+eSZ0I37uiKKVX0Rs+w2tMCnCDKfPG9JEFuCT7n3Fvxyvc3juu74wFYf4XLNGDEPMED0Oll6n6zGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114474; c=relaxed/simple;
	bh=6mvKhnpU9hOadKVgp4Cf8qdBVNpxvgwQBFQ0AUbLRZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaLv3Yw8mNUhWgZxEODevESEEiOZgOMj8gAqYcwKPP+3sirbfwrjD89BMvB+ymrfaUI0zOtK3aY1Q2ApiTVo+a8RLMO3OceTW4m3WWHjamqoC8UbQkg9114k7hGdDDMV07As2C/OMs5IVsrrCv/DjXe/WgyvZQGSuStkpElSKeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7CMr8kG; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7CMr8kG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b393d60so145811cf.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 17:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778114471; cv=none;
        d=google.com; s=arc-20240605;
        b=jB26S0tZxgjYr7Bb8FmNYjYzURsnhNJKYeeRYmqAJXQgACnRp935q/JBF5WyCEaiS3
         KsOxOLkAllYxeP22xfrFJ7SJqAgcHuz/E7s7kIUC7lrCLDaM0XkdbH2bWQXPLob+AImQ
         7ay2cj7Y3Q+JsLAMF7NxQe1VxeVNselJeseFu3k3epPlioKbI2pAsA/eMhTj3+upgE7O
         bzfSWn4eEnuRtt6vgvepLhXSe9m/V7EoMFjYWJ2iLhMpH5kNoxjsBnQa4ohJkr+VjUia
         T6syOZDxWPsCVJnQCMpeLxVv7f2aHpIBr3mX45QuayI3+vhohYzRcrK2/2G4bDpr83S9
         4ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cqjNit0Fbi38gGImMAXBiJbr+9RbVJutRvhEj2jXdM=;
        fh=dyYeAVXN0kD+rNYAMfvYifiCuFZWSRZXQsxjCut/Vjs=;
        b=f21NiW42/UgeRn2Zb9Hr5vT1DWiGmTTQNAG+TSORMjLhAluB5gSFWR7FPbl+9HhdKa
         b4A3Hrj5UKiTqitNDM/+8U7JSeosnKW6ni7cuG+jlA4TMDhZ87CsVFKev6o/CTvB8SzK
         SH7Xh+7i2ckZkc68zGrLSchO6WhlCYYKtwdl+cQSoGRVhQku3rEMVuGnr/28itiVaJMu
         63MPMf5U0WeWBhtKJDRakcqEJyQ12/dGlqYkZQmtIenSYCVdpxxVJ2RN9esG+lzi7LKS
         jjkVlaGUujDsMi/0NiZPZwdcTHnSWPPii+nqE1LMa6XjupJW311KfV6b7UNhvw0L+sOV
         E3cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778114471; x=1778719271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cqjNit0Fbi38gGImMAXBiJbr+9RbVJutRvhEj2jXdM=;
        b=B7CMr8kGNM8MkHvUTyztH0NzjKlkPebGqczkFGmq+jjMGX8qNq9gRLLRFJv/xtcq5X
         klJsxhOjGhwFDDMMQu44fc/8Y7b6FB2cn4gWwCAnNpxdjt9F3TbY+JLOkO97VbNftDdF
         21c6Cxp/It9bthk7kZsWayFADJfxMqL+A3W4cqIInkE3mqt5mRi8WomQ+YNjEG19PM0F
         8tVm3coo4wkIwPBBPhL4r4Jk9kJE6nsXdhHDA9C9ZCM8DhyKYLozzwprjfLCs53lx6uT
         3kIE2KUaeTSpB9WwHJeejaDmsKKvTXz/zMr5GsQ9a6o6JGVd5vBQnzWn9ouIYSupg43z
         IGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114471; x=1778719271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cqjNit0Fbi38gGImMAXBiJbr+9RbVJutRvhEj2jXdM=;
        b=VQsVWVZB8aUV8JXam9gVIS9tCb+YpSFPk17nrcEImoG7i1iV76FOFMR/2w2za1dIP5
         drxEUL3zKVAdL1r8A4IzOuZhi1OBSjaH6JxkvbfqtHOkOd+1Jj9I3nVHEoXEp1DL6MaV
         vtbdYtNkQIAb/yZhKWzGUVy2CZwq0A3Z3H/zGszcMFI1cB5B3ekXoA5R2pTdthCtWFUP
         LSDv+iCgIK3rfA+imcUmH0b2zxH9tNEtcGeeNOWxPW24jgsGrzkZ+TIQ4LUTrP7k/m2M
         1O9I6rvACgjtLugatvw9kyJNuYs/mChE4mFnO9ntiw+iZb88tphhFjUIa5Z8Tqvv8jli
         jNqQ==
X-Forwarded-Encrypted: i=1; AFNElJ94+qDIld96Z7alVmIJ3Qmqz4//zsq2d6UiqBH9kldKSX58mzJlLJqECVryO1gOFKBOvwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJt1csIjtDi3+lFgKC8h93hH9tsdtslqh3pt0rw9viMsArPqR
	U9O7Rnwh6Up1lHwX5X1Q1/YGl4tjsshzlCtTkBlSzbr+HW774g+SGXCP9iVYfKYKiGykwaua+9Q
	04GVd/AU8kYLbTm0UOvpLVf5cAcKUrjwKZepVhcDe
X-Gm-Gg: AeBDies+jnXvGUuc1RpY0Vuy7kmss4U0kl1bDN+cAIV+bMGUm1uy8aFBv+o0ApGQLD2
	LLo4yTPEZoXDKy/iUpvWL4D12DekmlyoSfLIcijt/mthzuogf652aGe+9QgxGJeDf4L9rFuylx8
	uubprfYnR/kfQ/1tGnAUOXngk8GrnGxWPGFJvEcxJ0lyx7JuNKQCkIJ2XIefsXR9BA1mdndVQi4
	H40hPS01F/+1ofVLMN5ijfaU2i3GCllfusrfHJbUC5/jQMlrxAzPLI6UgSjSLsWrKGKZOxkYOjW
	IB+MGu91ECDFEYLLhrwp3f7EEa9HD+7mRHfa4A3Ef8QmPVzRLivNWovDn71BpA==
X-Received: by 2002:ac8:5a4c:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-51473ca1162mr6101971cf.16.1778114470226; Wed, 06 May 2026
 17:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
 <20260505014118.3783476-3-vannapurve@google.com> <afvIuEuSYuktmtA2@google.com>
 <3dc2300e50f655e261115099b416c6a1abbb9e9d.camel@intel.com>
In-Reply-To: <3dc2300e50f655e261115099b416c6a1abbb9e9d.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 6 May 2026 17:40:58 -0700
X-Gm-Features: AVHnY4Jlvxg4mXwH-6iLlfw3pOOLlns02znWVQOkwbXoMjOm8vP5M-iWIFwBJHA
Message-ID: <CAGtprH8kn_mOQuwpoTBgg6WQC==cKh8fuYOpNOih_PjUgcUeGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>, 
	"mizhang@google.com" <mizhang@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:56=E2=80=AFPM Huang, Kai <kai.huang@intel.com> wro=
te:
>
> On Wed, 2026-05-06 at 16:03 -0700, Sean Christopherson wrote:
> > The question then becomes, do we keep patch 1 and also clear enable_pmu=
 in tdx.c,
> > or do we keep the ordering and have kvm_arch_init_vm() consume has_prot=
ected_pmu?
> > Neither one is particularly awesome :-/
>
> Maybe keeping patch 1 is slightly better?  This allows the vm_init() to t=
oggle
> all the values and flags that the default ones don't fit.  If we go with =
latter,
> when there's similar cases where we need more flags, then kvm_arch_init_v=
m()
> needs to consume more flags.

For now I have sent a v2 without moving around the default flags. It's
definitely better to move them up as done in patch1, but I think its
ok to keep the flow unchanged untill we have a more concrete reason to
do the move.

>
> This is also consistent with how KVM sets the existing kvm-
> >arch.shadow_mmio_value: KVM sets the default in kvm_arch_init_vm() ->
> kvm_mmu_init_vm(), and then TDX changes it to other values in tdx_vm_init=
().
