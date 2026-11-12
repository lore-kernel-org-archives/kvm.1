Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524947;
	b=zR39I2sJDTIXwHed++GHB5ZBLtiCY/o6CDSSAqgk09gEFdIHjv7XZhCYbXBPMDHMyQ1a
	 db1BaPxzs4iuc8EVBhx+vm8SU9hiYx7mpTs6AV/qPSsjwK/A+WspI8AU72q9/lIbuONYv
	 fNxD35INOkzmZ02Qoej/yLPeMvRspOihVFF2r2E8GfwIZ2BsRiHy6JV+pwIk+NJezGfcL
	 7MX2Cg38Z4ZHSy8t7ucSICjgwAs9/lPXAhklukBwwPfXZApU/xSQyaUpP8ICb+mUj5HIy
	 szIUMwbULR9x6Nxhq1ckkheb2tpQc2IyFwR5nW/HLOItMC5DmQdd3iYyv4LYq0JNP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524947;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=emYzY9rxTmsRQY49t45MjQb7ODP9YJHFljtMoqyKXro=;
	b=l+shOlNUJAvfeq3WqdP0njug+XsLykI+ZrZNAgDgp2x32qRa8F825koEXfAI/ZX3mfKF
	 XhQnxvNiFkHWcQ2njq8NAYyT6DfPyHJi2Vy6e+W2i9KWbYIyDtJWJLMND7ptSCATQbLBd
	 R3BBjUawweONMEBEK4+4+k9BntLjQ02FE7wKFWUvPG+5MTMjFu+GmSuNbj9DVOGmlPGep
	 N9aD3A8fMk43qWvTjN+XNo+nuT2FPsqPaIvqKIDq3lhtBP92kCfAPrlP2TdmggMAxGMvv
	 lo1bjEHYSty0G3rJET+U5MLF7Iv3oh5nUtwzIOIvkgw4Uu5c16len327OZ1giG7O7zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pfKgLnIk;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VZdxRlJL;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0D606A327;
	Thu, 12 Nov 2026 23:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAC0D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pfKgLnIk;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VZdxRlJL
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794524944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emYzY9rxTmsRQY49t45MjQb7ODP9YJHFljtMoqyKXro=;
	b=pfKgLnIkK5VYqxPXw/M/4onCiSqQpEAn0SKKM9UQxmZNYVZziYIUtso0pp5z7ddJ62g+v2
	R7kERzca9PZinbChyJJ6v44XOHuFPjude15qpxtMjYnkWQyA5uhF4TI4GrPg9OjUbOvzZs
	T+JKOxZhMb9CX+A3sBz3uueKlELrSpQubaSLC0d45rge/tmoyhgu6Z5aQvdD+TI82PSLqD
	o+Ghwxg6PqTNKj34u5xEXSmA/W7w4VKVo+Sn2Jn4CzXcs6yUEY0HV8O1Xm+eBA1pREwy7z
	3iMQjNhAmISHDCruy9jhcpEEjYfrqoelQ8QlouXngnoGF8/rAdFnd1KEFVKzHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794524944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emYzY9rxTmsRQY49t45MjQb7ODP9YJHFljtMoqyKXro=;
	b=VZdxRlJLITpXNo7LZV6xq9adCQJAtQYOFQXQICK7SSFj+2fp4OiHzjxdUItzp7Fri+vDWy
	xtm81V/SbLf2yYCQ==
To: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Breno
 Leitao <leitao@debian.org>
Cc: Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, vlad.wing@gmail.com,
 security@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
In-Reply-To: <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
 <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
 <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
 <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de>
Date: Fri, 13 Nov 2026 00:09:03 +0100
Message-ID: <87o6btsl4g.ffs@fw13>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 12 2026 at 22:23, Borislav Petkov wrote:
> On November 12, 2026 10:13:31 PM UTC, "H. Peter Anvin" <hpa@zytor.com> wrote:
>> Still, I have to wonder if it really makes sense to fold these leaves
>> like this, since they are going to be populated soon. Surely we're not
>> that short of bits?
>>
>
> If you mean the leaves in scattered.c, I'm thinking the moment a leaf
> appears there with half of its bits, it'll get moved to its own
> separate leaf.

Crap.

Even if a new leaf has only _ONE_ bit defined then it's a new leaf. This
whole "save space" nonsense has been source of a gazillion of subtle
bugs in the past and we just continue to "fix" them instead of actually
tackling the underlying problem.

Linux specific leafs want to be in a space which is reserved by
hardware for software purposes and not arbitrarily hacked into "holes".

Hardware defined leafs have to be represented by a proper entry even if
there is only one relevant bit in a leaf.

That's what I have proposed long ago and the CPUID database project

       https://x86-cpuid.org/

laid the ground for changing this whole mess to something structured and
well defined.

Some initial changes have made their way into mainline, but then Intel
stopped funding it and AMD has no money for that either...

So this will trickle along for another two decades with the same bugs
repeating themself over and over. WTF?

Thanks,

        tglx
