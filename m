Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850130;
	b=lPGXvczwsYpaNS0Ns2QaNhCQ2cdQtJDMOr+ri+y8BRl0FJ/lOOlrBMogRD6zj5ZRnpSY
	 RigEDeUNzL2tMhj4pWbxfFcLflw/0+fr0rkGuk4wEClJadciup7XfSpRoX/leAMozhBp2
	 roxCvD1DBhctxx5QhGnNx9BTqn3D9AfQvA4xMGykxMalxX9CFplWzP48yXSyrzGl5IViT
	 39Y+t4jRkrr0KYzv7535csfCIV+N2MjK6QlMpD1Swp0HE/D7OtZUe04TZ5zLHdKEGap1K
	 jC/i3TlpurwCCYikg5pmKSjarDzqMaZzL0LAct8BWZhZJGzgliUvSz+OYvvXkFLGw5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850130;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 Feedback-ID:X-Infomaniak-Routing;
	bh=sksj3erO0Akx5zzJjGKDAnrGDqLQmFXWSoMgfv5FcBI=;
	b=IJiF6of6CW/rtLBdb3VWyiGAip8pUq5e+7XSoWNk5hUvZIIcJBEBuBAIkbcLDcda4nxK
	 JPIi7OxScY3iVNLtPxgLd4oDtCN3GTPh65T+nwq+tTJZdcenZlcX37yAbHFw1+bojtzqJ
	 BBnma3tTMmUpX25jOtrWX0PCuz2o0wannYM9bu5qH4Vb/gJ/0HiYIYXxncrehtsnYGPNY
	 zATBaIN51E32az2tsRYreNYHMPdXLs0QPf6PyDoQ3uqDxHh0l9zrT1V4DLkuayAwlRf+z
	 aHEEqyRk6LO+YGC4BQZYqrAlA1flEL66wThWVDyHTDXjEwZeJZ5fv3kOZylJfMxGhkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=etik.com;
	spf=pass smtp.mailfrom=etik.com;
	arc=none smtp.remote-ip=84.16.66.168
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98218606A33D
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98218606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvwR05KVz2kNw;
	Mon, 16 Nov 2026 18:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1794850118;
	bh=sksj3erO0Akx5zzJjGKDAnrGDqLQmFXWSoMgfv5FcBI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=cQxdshKVjvsM39W9Gap2BRzIbXEaf1d/No2nWFKAUSwvNOUV8gHSyKC6R2d1cBd0C
	 MYDXtX311AflSc+xrxIyZzAIJKlRBSmJPWHwajQQAvOoDVjRXhbkkUF8hQv1ogIlAi
	 gGhu6QsEblH34EbgOm93qm2GRqDN3dpaW0DQdFEE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jSvwN6vjBzcsX;
	Mon, 16 Nov 2026 18:28:36 +0100 (CET)
Message-ID: <999079c0-c728-445b-a122-720d93f112cc@etik.com>
Date: Mon, 16 Nov 2026 18:28:36 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: DV <dv@etik.com>
Subject: Re: [PATCH] kvm: hyper-v: Delay firing of expired stimers
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Sean Christopherson
 <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 hpa@zytor.com, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 nh-open-source@amazon.com, gurugubs@amazon.com, jalliste@amazon.co.uk,
 Michael Kelley <mhklinux@outlook.com>, John Starks <jostarks@microsoft.com>,
 David Woodhouse <dwmw2@infradead.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20260115141520.24176-1-graf@amazon.com>
 <aXO8I6xuZyZB7CxV@google.com>
 <769f538d-dd42-4d36-a4c5-7e6e48b209f6@amazon.com> <87bjigaeyx.fsf@redhat.com>
 <1435d106-d4b0-487e-85d3-4032a9fe9332@etik.com>
 <kupzev8hf8s.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Content-Language: en-US
In-Reply-To: <kupzev8hf8s.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: :74c292bbbde641d:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha

On Mon, 16 Nov 2026, Vitaly Kuznetsov wrote:
> From what I remember, direct mode synthetic timers were added
> specifically to aid Hyper-V-on-KVM case as non-nested Windows was
> preferring non-direct version anyway. So I believe we need a fix and
> not 3).

Thanks, that rules out 3).

> I'm wondering if the issue is somewhat related to the nasty hack we
> put in commit 0469f2f7ab4c ("KVM: x86: hyper-v: Don't touch TSC page
> values when guest opted for re-enlightenment") but maybe hibernation
> is somewhat different. Or maybe we misunderstood the problem in the
> first place and only fixed one sympthom of it?

I don't think the hack itself is involved here, but your second guess
fits what I see.

The hack only takes effect once the guest has written
HV_X64_MSR_TSC_EMULATION_CONTROL. In the failing setup
hv-reenlightenment isn't exposed, so KVM recomputes the TSC page on
every masterclock update and every KVM_SET_CLOCK as usual. With
hv-reenlightenment on, X was 494.7 ms and the timers were just as
late. I didn't trace whether L1 wrote the MSR in that run, but it
wouldn't change the lag at boot: L1 enabling the page sets
HV_TSC_PAGE_GUEST_CHANGED, so the first setup is computed normally
either way.

What points to your second guess: X is already in kvmclock before the
guest runs its first instruction, so when L1 enables the TSC page,
KVM writes a tsc_offset of about -X into it. Yet on a boot with no
pause and no migration, L1's counts were still X too far out. If L1
used the values it read from the TSC page, even cached ones, it would
have been right at that point. So L1 seems to take L0's reference
time to be guest TSC / TSC frequency with no offset at all, perhaps
because on a Hyper-V host the two start together.

If so, the 2021 migration storm and this are the same assumption
broken in two ways. The hack keeps tsc_offset from changing after L1
has started, which helps on migration, but it can't help when
tsc_offset isn't zero to begin with. And without re-enlightenment,
nothing keeps it from changing on pause/resume, which matches the
virsh suspend result in my first mail.

If it helps, I can rerun with hv-reenlightenment on, trace whether L1
writes HV_X64_MSR_TSC_EMULATION_CONTROL, and repeat the suspend. If
the hack engages, I'd expect X to stay the same across the pause,
while the timers stay X late from boot.

As before, Claude Code did the code reading for this.

Thanks,
David
