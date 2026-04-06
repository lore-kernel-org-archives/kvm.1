Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40493806C7
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485425; cv=pass; b=a/CcVF21vSR/+gTtI8QBPRuqaQRPO3sUPWoZOtKJRX/RNp+MF9S6LA8y6jgXjEJHPIBNoHKtEU19di508syE8h2a0SdV2iyNYaS72eTUyZ2pv1d9j5gEY+JD1uLcEqwXor2y3dYAKs3j2Ckc6JgDohYGapG8jQqTSPR1bFRcAX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485425; c=relaxed/simple;
	bh=0oshv46xLuQzPLIPdH9A0EvaVpAKTWV20KUKhaXBiSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEm7Crs8KWtPY9dA00angU+TsGzFBB+9llrTOve4WvFV9Lqsxg0UXTJHHpgP2Cm44kGIQYsM/MARKmHZgLR+G05erADeWI1sAGthPyRlmCAFDHW4oYxlfYg2A1M7/vwHFbxCOEQEKjz7tWr9PMJ2r0o21WjVCOHTTT+WZ2q8+OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeoTYTd5; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeoTYTd5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso21596a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 07:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485422; cv=none;
        d=google.com; s=arc-20240605;
        b=N8gzqRC2nsW7AyJrSGTQbgZq/ILNOiFB97aL18Blv5WnGQbw3yMnmM1YvGDNfdJblM
         Wd91dceyCqN8eWFqii7jt/ev4IBQIcEO+zVJ4odH3GqPYhiGcdp/g4cBKlRd/D+FBu0z
         uViGrpxjLeSoZb3CoBRGxlOzy/ZOhbruHF/b4kSLUpOZR+8KIye6bZpI/mDdJqP6jDrc
         AStCcE6b6FD51r+Fxw5I8ujogyp+48sJ8KAgjbsDOkggame/PFNBnu84vLUFcBjZ9wKr
         TqwumRK1VApWOByHPURtkzz0otQRa2N2fxnhXzHFj1xpEMTmhxqsoztCcAcSLLnyfQHw
         LYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        fh=2sbKZxCHWDTaSnw21S9ZiI4e/DC0mpRW0WFQdkR5ESE=;
        b=XB4nWLpCzZk/M45ZAMFPTPhux3BktgJ9uGQc9DV7YlY9xGuyRe5eMivadZBIhazO/s
         vkxfeF50Tw/UvJmIKYOsBl7288nMnJcS7uWKgtd2PFVs5htABI98uJ3OZTSI7HfoUdld
         wANbglhfvpOLKitPWYBI3pOZ5BUxegZJp8XNZp1zLoiwfUNS34tOcKaVM8izABaLEyo4
         JNPaQ/UBX1egd6OyqalfwfcM014qtZi1YskG65x28Uvc1Ic34B7WL2eypPdWfTKrEtn7
         OG7CN3BALlVC+87KSe/qxciTCvbz76/JPCdztZEgtY/J+azMQcfKqjbJmqdkiQbm8H/x
         Zc/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775485422; x=1776090222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=XeoTYTd5wSE48JW8kaM0qv3ycrSE9eyeuCIskQwqlA84Ij2A9Xf6y3+NEG1J8FRvIQ
         t6bHLyFisYQzufw6dVUDCO8+C3SQMB2M3WjdVqRea1tMTT1qZ12ijqURJCW5YdMxgO/U
         0iX1FKr+yUwYvrYESOPuxPlwn8N0qKaPS2HrSIaYdfALRFDkTWB6DFUsYj2vLBsIzzdt
         uxeS2dppQQhcpnblsFY4Z4BNYMbYJ5yQSZk4VljRhDO6MTvR1NaxLYhYgKToGQoccHBJ
         uk0Miz7PmU3O0o3kStbFvFjYl8NPwzt9LvF2y0FdSXBEcd20f/V0vddkkgTmfWnI5ZQF
         agZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485422; x=1776090222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4foAE2z+Q/MQv2J0mPBdcU98fqKB0vyTweCETb8dfag=;
        b=rbS4wurcHWff5FgrSX79ZSCH22qAdD3sHdRGSofJGDR6xodO16zK4zwY0aO2P3Pnn1
         Rq1rH2MD6u39Bm4ak/0mn927Oq47SRlZd4pAM6o2CIfNSoTHEcw6s58k71kn1n1FgWK0
         oNPUQwFTsCn2IwyIcG5RZ5nzEHRBiuQo3iBqZQT5tRyQg6sK4d8R/CEsVvn8j2n1bhTW
         zDYka3X69C6QWIrSiEHX1ZXUEqSrblWeKA7Cb8oBqXxz+mPzhSwo/0n5/1zEg1EdW0aj
         ByiFBKwgzkEEAmV6IvfAYAIU6ZXB6rwnqnv8QbKi5PqG2mXebqeCqcqHEea4Xd5Iz0Q0
         G6JA==
X-Forwarded-Encrypted: i=1; AJvYcCXuwHVhF+tvpfs65YZBiWACdCNag/wG2VxSK9gHFRKYb4jbDSU6k/irREX2hADbXuXqrVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EcOQBKl4A9+bjaPSr73SY1lSXaXLhrImT2G3X/Vq37Ylh4E9
	oQNIdJR7VeCRBsi9N1GO5/pA5lfQWN3H+8SIIgHiG607EslKy7uJjlH5iabpd/knFT1+0whHhXL
	ABmz5pNBKHNSdfYZb1UAsUG7ktEvdiSauK2r0jVTH
X-Gm-Gg: AeBDietvr+XG9KJ6wNIQ4TrqdT4sMZx06H6G6wkaIdyTwqZCo/EfRWfWvksFVt2oVtg
	I1QsvWVEVyghuIB1gy8fuCzDPilfRipFP/VQPxMEYOlgDueKTO4QVpJw+fU0IXyZ9Gs+DGKWjKW
	ldjvd9YY739zG2CrejvuF+gzlh03qs3gxnw4F/vurQPMW4aQpmITZK7seYo+cNeB9Yo8WbOf9l3
	ugEjGAo9Sawn1W6heiHhPpqVfKheYDB3tjIEq8LnrS7CbokzS68s7aCMgdu2dvD2W8l60VcNwo2
	m2la6t0xRGqkXnxbDg==
X-Received: by 2002:aa7:c383:0:b0:66a:7b3d:f43a with SMTP id
 4fb4d7f45d1cf-66e43cdc3d3mr75635a12.1.1775485421479; Mon, 06 Apr 2026
 07:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
In-Reply-To: <20260404034954.t7iapenzvhdpagxp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 07:23:25 -0700
X-Gm-Features: AQROBzBKIPcP_H1GwuJoXUrRRJVPGk443GCqm_WEh0Cd97H-YqzPVn5MR8nDNUU
Message-ID: <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 8:50=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 07:21:02PM -0700, Jim Mattson wrote:
> > On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > > > Since cloud providers have greater control over userspace, the de=
cision to
> > > > > use BHI_DIS_S or not can be left to them. KVM would simply follow=
 what it
> > > > > is asked to do by the userspace.
> > > >
> > > > I feel like we've gone over this before, but if userspace tells KVM
> > > > not to enable BHI_DIS_S, how do we inform Windows that it needs to =
do
> > > > the longer clearing sequence, despite the fact that the virtual CPU=
 is
> > > > masquerading as Ice Lake?
> > >
> > > IMO, if an OS is allergic to a hardware mitigation, and is also aware=
 that
> > > it is virtualized, it should default to a sw mitigation that works ev=
erywhere.
> >
> > Agreed. So, without any information to the contrary, VMs should assume
> > the long BHB clearing sequence is required.
> >
> > Returning to my earlier comment, the test should be:
> >
> > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
> > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
> > +               bhb_seq_outer_loop =3D 12;
> > +               bhb_seq_inner_loop =3D 7;
> > +       }
>
> To be clear, my comment was for an OS that doesn't want BHI_DIS_S
> under-the-hood with virtual-SPEC_CTRL. Linux doesn't have that problem,
> hardware mitigation on Linux is perfectly okay.

Today, BHI_DIS_S under-the-hood isn't offered. If the hypervisor
doesn't offer the paravirtual mitigation MSRs, the guest must assume
that the hypervisor will not set BHI_DIS_S on its behalf.

> Without virtual-SPEC_CTRL, the problem set is limited to guests that
> migrate accross Alder Lake generation CPUs. As you mentioned the change i=
n
> MAXPHYADDR makes it unlikely.

I have been unable to make a compelling argument for not crossing this
boundary. The only applications I can point to that are broken by the
missing reserved bits are (nested) hypervisors using shadow-paging.
Since both nVMX and nSVM support TDP, the niche cache isn't a concern.
There are compelling business reasons to support seamless migration
from pre-Alder Lake to post-Alder Lake. If you know of any other
applications that will fail with a mis-emulated smaller MAXPHYADDR,
please let me know.

> With virtual-SPEC_CTRL support, guests that fall into the subset that
> migrate inspite of MAXPHYADDR change would also be mitigated. Then, on to=
p
> of hardware mitigation, deploying the long sequence in the guest would
> incur a significant performance penalty for no good reason.

Yes, but the guest needs a way to determine whether the hypervisor
will do what's necessary to make the short sequence effective. And, in
particular, no KVM hypervisor today is prepared to do that.

When running under a hypervisor, without BHI_CTRL and without any
evidence to the contrary, the guest must assume that the longer
sequence is necessary. At the very least, we need a CPUID or MSR bit
that says, "the short BHB clearing sequence is adequate for this
vCPU."
