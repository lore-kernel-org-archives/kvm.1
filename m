Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBD48A2C3;
	Wed,  6 May 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076584; cv=none; b=ZeG907Eiu9qQ5GeR09d9DUHsq8TeLWAPyV3RIl0ro4fqn5GWOWT5PTQW2Pq3GnTjUgp0kBmp0eG4RGNNJ4YUFrjmIe2FLHZ/Ip/CaaImgKSP4Oxycf89ctiRYMwBQ3ewtDPUA1uSXFggKERXkuCRKOeXQKS38j+VTSmG5JjY8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076584; c=relaxed/simple;
	bh=dLMzTIlsf8u3vWQqIt6u4RzedkOwO8gdUDZbUbQiZFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjQq46CuJ98UwsmEguD6Si1Hc0+XLbu+Oxx6YNTd6sqWnyRCcgXsEuDx9UEDXNi/uGIACViEfxOQNLRQxOQmBQutJ7PsgpxaCYjFrk4GqgkYlvgri6bJMplKgQ85XZlwDU2RImvxrWrcLvgySR1xFaJTuB4PzuqULFtBE29kvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cSM0ZyeQ; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cSM0ZyeQ"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4g9chF61bjz6BK4;
	Wed,  6 May 2026 16:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778076573;
	bh=dLMzTIlsf8u3vWQqIt6u4RzedkOwO8gdUDZbUbQiZFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cSM0ZyeQMbFfJVBzbWpcxEiUfzeNauH+RPK9uqHkulPNTu/Q4ulPBH+lTu1cxCVES
	 VAmynWLzmKYer9VIjsM1jajd8mgWbRTEjRkHcseRDegPkF1hW5pKB+CpF7+DoM9l0j
	 1szih5FOe2ksKkfcC5lNnbmWsSya3+re9e3YawVPEMESj9WQ0sppLXaw8ZiVbqJlkD
	 1V+PteOuaXTV0uEO6WSnnJ3z0TbtrYCv5dXbNX7qf1zSEIMXUHBvRqIcQePNpr5tRz
	 RpMn+Avkx3NnJA5bM/A5rzAU+yZNn5chsYVRYLP4hSP95ACyC4VaFEcU5+YM93dC0r
	 RkicrYpkdkWfA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4g9chF5H4Cz4xPS;
	Wed,  6 May 2026 16:09:33 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g9chD16Stz8svX;
	Wed,  6 May 2026 16:09:32 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8D20C632F8;
	Wed,  6 May 2026 16:09:30 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <cd8a2ae6-a276-480d-b942-bcd318a30451@leemhuis.info>
Date: Wed, 6 May 2026 16:09:29 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
To: Sean Christopherson <seanjc@google.com>
Cc: Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, jan.cipa@gooddata.com,
 jaroslav.pulchart@gooddata.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <adVGrJaRlRooO4su@google.com>
 <20260409142226.2581-1-lei.chen@smartx.com> <adf8Q1VSeAMMyCa_@google.com>
 <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
 <afs6PJzU3rHZwGv3@google.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <afs6PJzU3rHZwGv3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177807657100.1311162.6115906995068531430@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 8D20C632F8
X-NC-CID: NqtYnr1UR+BGfbCZQZ7Fp/D2FLy9WXfOp+ed+vv8MZoKMeHD8BM=

On 5/6/26 14:55, Sean Christopherson wrote:
> On Wed, May 06, 2026, Thorsten Leemhuis wrote:
>> On 4/9/26 21:21, Sean Christopherson wrote:
>>> On Thu, Apr 09, 2026, Lei Chen wrote:
>>>> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
>>>> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
>>>>
>>>> As a result, kvm_arch_vcpu_load() can queue global clock update requests
>>>> every time a vCPU is scheduled when the master clock is disabled or when
>>>> the vCPU is loaded for the first time.
>>>>
>>>> Restore the throttling with a per-VM ratelimit state and gate
>>>> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
>>>> scheduling does not generate a steady stream of redundant clock update
>>>> requests.
>>>>
>>>> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
>>>> Signed-off-by: Lei Chen <lei.chen@smartx.com>
>>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>>>> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
>>
>> Was this performance regression ever addressed?
> Nope, not yet.
> 
>> Looks like this fall through the cracks, but it's easy to miss something.
> 
> It's in my list of patches to apply (probably for 7.2?).  I didn't want to squeeze
> it into the initial 7.1 pull request for a variety of reasons.

Hmmm. CCing Linus so he can speak up if he wants to about the following:

Given that this is a fix for a performance regression[1] I'd say it's
not as urgent as a "something stopped working" case -- so I guess it's
something where the "[fix] "within a week", preferably before the next
rc" approach Linus recently mentioned does not need to be applied strictly.

But Jaroslav OTOH reported it more than 7 weeks ago already and back
then called it something that "severely impacts KVM hosts running many
Firecracker microVMs."[1]; and a potential fix exists for 4 weeks
already. Due to that, 7.2 feels a bit too far away for me, as that is
still ~15 weeks away. But maybe that's just me.

Ciao, Thorsten

[1]
https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
