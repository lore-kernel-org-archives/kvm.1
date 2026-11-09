Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262063;
	b=PVdGX9BsUZTZqPq04fRSrCx/2o3P7Brpkpn1CqztVnkcUyukgggiLt2/yUWlf14aUioq
	 XLa5KMZqtL7t9FO46xYygu2Zn9FXrwhwHRcLOIONatDcvBVz26OK4bmOLgoDAgu8IYXD7
	 VVwW2S4usfsQ1PkxUVNdFeYAod0F1bQFy08T/ZrXWzoK95ZavMps95MqQK6jzhlVnqCj+
	 cNCjpNCm6ayzc+ld/jMOMw8xSAdY3StUOX5K8LDGzzZok7iJ/Euv5DmE1YKyQK9QkG0zc
	 4I/7SzQIrtC5J+vdUiWKaaB53kRTdTboUWrtYWw8EN+LGTwyH35kG+qg1+Ej5usE8WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262063;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/Jiqd0tBE0ZLezzleQnFIB6zQfFW4nQzZquT/KqFgKI=;
	b=f1JkN7cGpipYuI/aRbWz/1h7eXd61XLJgRGnRY78ETmTAF4Hf9qLQmWCGSWDgmOwEJ+0
	 e5P+hHOOHV/gwOrAXwnHWwY9e39pf4SJwZm/SXwBIlsNZAP6BZsiRm9KDcq7ejTsV8bAO
	 P5d2GdPAteLn48XotqGR+bw5ZyKHp3ipt8Rlt4LqGS5MY3LutqQfhRf++MP4pu81CgFeR
	 GB2GGyREfhtUaYygyhf+Y2RiZxnjl1KsK6iRUyxxJzq+9xGyPehnR5aJaxu6f5aFKzU0W
	 luiN7iTrv3tG8zKk1hDqgThxmJff9oMgAGJHfZYb4S8M//yIjarkDLp0mBr0m0h6SeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fehpc9+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5D606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fehpc9+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F06E1F008BF
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262062;
	bh=/Jiqd0tBE0ZLezzleQnFIB6zQfFW4nQzZquT/KqFgKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fehpc9+Z+TqgkyOzbUQBTd9qRYAqw8jOiIMd3KRPoQ2TwVE+s+WAwLOJgQ80q5MV7
	 YMa5Cc7g0w35Q0+mNFj7KfmxGe7bsGVCPobGitM7eZyrxGQ1/NV3HURm4/2L23LXBz
	 iJ5eiKJq2DtaS0crHkTd3zbNQrEOmtoL6od6zaZULMLdmMN6UqdnXFDTp3xr/eacnB
	 OOHoHmh+xzKheFzml5kRZWZMPR17ehps5qaCzCvPEfkdvYgRLm9tdgi0VnMADX61C6
	 +tCG/iy1Qwi7LmvIaI7hnS5i4QWH/iPiWjipBe1ESBV783lVL0WOGd9tKAhp8rGNLG
	 G/bVwG/BZ5ItA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d58c50743so20843466b.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:07:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFZllRXEvcN8cyQ7d/bOhLT6CETJ7snHQ+hpsze3+URM8Ml2NHpZ3seIvESnZcFfE89J94=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ss203BMR4/PnqFcOT28RX2ickGFS/e94kdPaZj1f3eyiyoidR
	Dj50GEFStoSMN9IilZbPRmbCnGFumHCRZoYM5iVp+8sLSjEdA6osljVskviUQCvcD+ckujcrYVG
	JiEzyhu3//tWbABX43WoOL4WRUqr3jlI=
X-Received: by 2002:a17:907:3ccb:b0:c40:80eb:c541 with SMTP id
 a640c23a62f3a-c5049320f8cmr52819266b.2.1794262061283; Mon, 09 Nov 2026
 14:07:41 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-5-zide.chen@intel.com>
 <au4kyULjUYdqbfIq@google.com> <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
 <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com> <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
 <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com> <avI20tEzyvIshy2f@google.com>
 <650a864a-2f20-4864-b29f-7cbe822e894a@intel.com>
In-Reply-To: <650a864a-2f20-4864-b29f-7cbe822e894a@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 9 Nov 2026 14:07:29 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOOub+rY-6twk8jBkKJZJsvQnJGMqXBo-eEEyD5+1rang@mail.gmail.com>
X-Gm-Features: AclHuK_wkAMoz3bhZrOB8V7yo2pVD8uY4oTcxfe0z36IThxkzt1RLmUTYiwHlKU
Message-ID: <CAO9r8zOOub+rY-6twk8jBkKJZJsvQnJGMqXBo-eEEyD5+1rang@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > index 98e6f2443b82e..37a6664fdb9c9 100644
> > --- a/arch/x86/kvm/pmu.h
> > +++ b/arch/x86/kvm/pmu.h
> > @@ -149,11 +149,11 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(=
struct kvm_pmu *pmu, int idx)
> >   * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_C=
OUNTERS,
> >   * so iteration up to KVM's maximum counter count is safe.
> >   */
> > -#define kvm_for_each_gp_counter(i, mask)     \
> > -     for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> > +#define kvm_for_each_gp_counter(i, pmu)      \
> > +     for_each_set_bit((i), &(unsigned long){ kvm_gp_pmc_mask(pmu) }, K=
VM_MAX_NR_GP_COUNTERS)
> >
> > -#define kvm_for_each_fixed_counter(i, mask)  \
> > -     for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> > +#define kvm_for_each_fixed_counter(i, pmu)   \
> > +     for_each_set_bit((i), &(unsigned long){ kvm_fixed_pmc_mask(pmu) }=
, KVM_MAX_NR_FIXED_COUNTERS)
>
> Right, I didn't realize C99 compound literals could be used here.
>
> However, with this suggested code, kvm_gp_pmc_mask() would be
> re-evaluated on every iteration. It seems this =E2=80=9Cexpression with s=
ide
> effects evaluated more than once=E2=80=9D is not encouraged by the coding=
 style,
> is it?

kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() have no side effects, right?
