Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EB3C09F9
	for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018967; cv=none; b=cavTyFNi6Y7c8Q+FV+ySwwlpVpTItVAfUvzhXp0eKfPpf2JA+Kw7yGhnhLUC2Ls/rplFd75YwxIXhhprmkGo5xME/D9jiL6dqWhknt3YvgWOvlkCrmd3jgLah7uUAmOnqzm2149+Q1OcMYRcb2A5Kw+UYQo+eag/jw/+ZMjDM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018967; c=relaxed/simple;
	bh=3dTe4I+jOUWdWEDTdrRhpKO6zN5DvkrePHACeVTRXMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oneJSC70kFV2xoygShEBDA8QbRp2c78MEWHaJZRua24wMdfl3INPzONbTXwpKIhmw3jRcJWhraiwtoriDASLhqW4hIImSlD9N3Qnijiqb9sZdSv/2LdYopsTLcRtknUAJP5vR4G6pZhHUTe5Enaw7P+RQKmgGcwIWG10wrh8fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTWjr/Jn; arc=none smtp.client-ip=95.215.58.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sTWjr/Jn"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3dTe4I+jOUWdWEDTdrRhpKO6zN5DvkrePHACeVTRXMA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788018955; v=1; x=1788623755;
 b=sTWjr/JnVki2nTmcOaMZc9O3H1O3c+xEABvSC1lVbWiBMpwSPkMXmkUZuwaCsOxtlljQCCFd
 S3+MYGZaE/W3Puxz5uFqhk/kv5BvP9utXxroniTzz9JmTXtFBE/Ob986ZfwVPWJSkS7bTONC1WM
 z5bQ/KgRRQh3pgLp80Zc9Al0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2cfe5d2258c34028;
	Sat, 29 Aug 2026 15:55:55 +0000
X-Mizu-Trace-ID: 2cfe5d2258c34028
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so4298e87.0
        for <kvm@vger.kernel.org>; Sat, 29 Aug 2026 08:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3+eMceuJAdxpk3ucnmhmpsMT68kXOoLcvsilfqwgmKOC1km8c68iliupmmTGrVD+d6eI=@vger.kernel.org
X-Gm-Message-State: AFuF++l9345Tt3l5NgsTqe2FjEzDBrYtfkqk3YS5cEcJJ50nPGp7+LZi
	MubCRMcARqPoCwtlrHZP7RmYZL+T0ktxfXITodZU6rbjoG9ha4F3UY6jnP4+D7/pFmPe1wWnsg0
	hqB2aGpuLx3iWcrb0uxbdcfMmwEj28UB6QDEjKvjX
X-Received: by 2002:a05:6512:4484:b0:5b1:ca0b:25d2 with SMTP id
 2adb3069b0e04-5b5ef1bf21emr94137e87.4.1788018952785; Sat, 29 Aug 2026
 08:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829054856.70549-1-kmehltretter@gmail.com>
 <20260829054856.70549-2-kmehltretter@gmail.com> <CA+EHjTzQM0bf1x2X-Y+eMmUHSYUmJXpt_jQ4Csu7JpkjtFT72Q@mail.gmail.com>
 <apL9jzg-KM_n3Vv2@gmail.com>
In-Reply-To: <apL9jzg-KM_n3Vv2@gmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 29 Aug 2026 16:55:16 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzP0ijpos=1UOTz36b6_e1Ux90rNPm8HV5AKRhMOd76Zg@mail.gmail.com>
X-Gm-Features: AcwNN1VTjw50xqm9AUGeQ2iOjooRY4VH0Aw3j5JN4xMy5Uv_aVYtiX-pVxGi2Is
Message-ID: <CA+EHjTzP0ijpos=1UOTz36b6_e1Ux90rNPm8HV5AKRhMOd76Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Return -EINVAL for an empty SMCCC filter
 range at base 0
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Aug 2026 at 16:53, Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> On Sat, Aug 29, 2026 at 04:04:01PM +0100, Fuad Tabba wrote:
> > > Fixes: 821d935c87bc ("KVM: arm64: Introduce support for userspace SMCCC filtering")
> > > Assisted-by: LLM
> >
> > nit: this should be `Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1]
> > [TOOL2]` rather than LLM
> >
>
> When I first saw 'LLM' in a patch I thought so too.
>
> But it is now allowed, see recent discussion and merge:
>
>   https://lore.kernel.org/r/87qzkuahlr.fsf@trenco.lwn.net/

I missed that. Makes sense to be honest. Either way, that was just a nit :)

Thanks!
/fuad

>
>   816d9992d9ed ("coding-assistants: simplify attribution")
>
> > Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> > Tested-by: Fuad Tabba < fuad.tabba@linux.dev>
>
> Thanks for the review and also testing!
>
> Karl
