Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5120E702
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775269278; cv=pass; b=t0Ep7qic0V/QF6N62lCHMrkSnN3ndBLFd77E3qGb8lCkN8kwtV4hA2KVnlh3X89oryIYAvusmMWQR1x6Pa+nweJQawQjjsK9RbsfZWFU8T4Jqwmetg3tphJ2gePB0+Hd2JV9Ra46UUDzFX+60kSXWCBexqcrGmjeEKN1RrEE8Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775269278; c=relaxed/simple;
	bh=QKK3vfyE3OByfcbnSQwgv55pP7KZYyyoT/ZClNEydVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISmBQfNNinRElbkC6qnVt8b8zSAFoz9LpZWkGEgWW1zhLi/mCJ9NnXOIqh/roceBEuA9rqClTx6esFKfibAwpihp3MsU0IgVQTCpID+lC9q3HtorGMhxUdK9P0LGuQENhQCIB3BGPPPHyS1BrrFE6juni5A5FWQP+SSoFfc+vu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFZ5CNRz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFZ5CNRz"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso12913a12.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 19:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775269275; cv=none;
        d=google.com; s=arc-20240605;
        b=gh5Fn6pjTFi1RaFxa/w9B6nAuO3+Jfn1ZX7qtQL5U/uKu0THnOMyNL/yYZjBCvCszL
         ug57i11DI0VkQ6/VeYIl3yF6IKQPxDYA2r3S+tWYUQsGRfC+Y5k9gLSfmvqlQHbfdk8i
         Nko3Hd5Zo+2d6RM9DwsGwmrjAPV4JPtORynu+QiSPIpnNGDVpgbWAbVaUBEqRE8V5NF4
         g4SMS0ZKjEBXAFOEh7DdlijQi45gPMrUw1L20vFvO5P0CZFv0vT8ohM7MCSmSKkNbG4J
         LIZ6aW89cJIoKr9jAmNK1P4Eg4NOGT8JyJisZV4A2XnCCMvIWJVS8SlG1IPlWmuNqPOQ
         3SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        fh=LO/mI1fDt6mtHg+Vn8HJ1UsmuzQbSHUHo68sLOzR2NU=;
        b=C44C5vAn1vc473SEWEbOxzo3VjWiuWSvbYt8ycrOXxoNa0VNAoGOSAIoqiGjBgk/AF
         dDcZylhig/uT7HFHVEwc/ynTOlPnGNw05KEC4Ou6yEcZkXt8eTSHWB67W4S398lHDXsM
         d4DFszmSybt6ItsxbHJo417jmdfobfvFFmaRcl9KYEoeyBHgFRPnUO/e0NxYtVAeBgUn
         hf24D0wOkciq3Mp/u3e0WsOEO+n1h/YWIwuOF9bph3h+9fYhqWmW+VXl03yCAW32C34R
         dddWfXCJaIdz2VgksA7Wkp9V+XbJSvAzglqMEqgc5HL0kFix7TrNw0x5ZG5kiy7+nr9n
         N1OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775269275; x=1775874075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=mFZ5CNRzhSAbWxV9qEwfLjfxOOP7DEerPOJ44lwZkjp5L0uoXrsRQWWpXvSSDN4Cwo
         k3qLye3m7czPV1KRG1YwJLNmVknn90IHrEFd+SEYT83REKPPEDEF27RQJWOaYm8vr5Mc
         ARt2SMt9qNbsDFnF1i/h13uotWnRYenua3pnrUqy5O1F/7zThm1qfGM5Fc55s75pWyY0
         q4FZWGS8Xs928aEmrZOHOfrCI6S7QgmhPn0SlpxVv8Cq7JNHWWU4jT8KhFsVsqaifCqU
         8LTPEk17nAIKfFlYGH/o2e/+7vrvBzxwJc9f4mXHfqtkt9b3pw64CSnJbIhLfgpHkhBS
         4zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775269275; x=1775874075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=GiuoEe6k5bYTlut9FCDDOqYr/X8CeMGEy/TZ9oDSRJLOVoFAqcUun2uB6eRLi9OYzr
         Omm1S+mTfOzC4AQ6AUpOR4Oa8i43NLHvHTO+EQoiC8X6m+vXIidIch1mq9pxarvouXfx
         rV7lWMOpOMkiBV11gCL5hGmN+iAbcXSYfypTd8AH0rxYqeZsMXPtM6TGDhVExD64kKT8
         kIB5QuV6D4FJ4LW/k1h3rmRNMT7KduXYg6ZbZ+eGPpo/ezA/AsCd+nPwxtWlvnUOtwio
         hda6kD1+fPx6anzmxWOGemVxsjhKSm/TUQJ1x+ik0a8j4TxFSzR4W5X/vxEklKrbFI6O
         eCpg==
X-Forwarded-Encrypted: i=1; AJvYcCVHtDp840FVFE/CgsEFeg/W2AccdVlrkaosKxau9cAa3qny8tm8m1AE7TD2Nj/7y4yn/Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dZn+G1rTJN8Rih3RgH5ycb0e9Ln/1vH4s3Bxm8peohi3Js0u
	oVO4IPqIGQqxa3EiM7z5w9p1x4ZwfyNTc1JxgidJQAgl1f/fVsHhZMOZsGtaoh+0vj1twEvZxJP
	AgFh2SPt36xQJ1neVVLzIP+hXBbrzhIl4MjHVaYy4
X-Gm-Gg: AeBDiev6KLFhZ3IReA5wXqwJJjHeNi5yU1QvmAnh2Swif7p8jsx3rbRRGjeWcsSDDEN
	kyZRSE3WWSPQnF75H21szXrcEdr0mEfXbvhhSoYEq/gXRGRDFqRGP7MbkfmEp4/cuukYyCDjYMX
	KS5xAwkttm5meVDNn6L7b8o9giY7HLbk6l9cja0jNaXScDBi746SFNmQMqZJ7Ozak7Vpebq4PTX
	ImTxjfeXhyG027YT98WKDxMU18ZdapezavgoZSutAUIMjaMxYVWXvBW59ckwSGAtLd2fD+qzJoe
	0GmH4p3ikuV77TtZgg==
X-Received: by 2002:a05:6402:1804:b0:66b:ed69:a85c with SMTP id
 4fb4d7f45d1cf-66e43f22b75mr45332a12.7.1775269275001; Fri, 03 Apr 2026
 19:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
In-Reply-To: <20260404002149.wtayv6a64vzuppgp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 19:21:02 -0700
X-Gm-Features: AQROBzBosyujpEg2ULZMen-BYMNgkEIJxtpk1WSLwb-MqoCqV3Cx2KzliC39bhw
Message-ID: <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
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

On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > Since cloud providers have greater control over userspace, the decisi=
on to
> > > use BHI_DIS_S or not can be left to them. KVM would simply follow wha=
t it
> > > is asked to do by the userspace.
> >
> > I feel like we've gone over this before, but if userspace tells KVM
> > not to enable BHI_DIS_S, how do we inform Windows that it needs to do
> > the longer clearing sequence, despite the fact that the virtual CPU is
> > masquerading as Ice Lake?
>
> IMO, if an OS is allergic to a hardware mitigation, and is also aware tha=
t
> it is virtualized, it should default to a sw mitigation that works everyw=
here.

Agreed. So, without any information to the contrary, VMs should assume
the long BHB clearing sequence is required.

Returning to my earlier comment, the test should be:

+       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+               bhb_seq_outer_loop =3D 12;
+               bhb_seq_inner_loop =3D 7;
+       }
