Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019811;
	b=kWAX4Tmk/ZIYP8fdkkGjGKtfBt81X47MspLrU530k2qLy0HRe//Pnp0tD81HNI2T7vIX
	 z+wU0RnwiIqyf5mIS9JGBzS87f6nCE1Ew9xVPl9+n5h/4mSX+HMVVswKy59odvMighKn4
	 NnjgWwSSpVW5Fcr5Wk9w77oKi+NztEUCsdiEE40LdYQUMqezhSOffcs2WNbLavKiCkphl
	 OfMwKcq+j9bfnlGWogr52smO5+f0JV7XBnNpclSzt18YCCh4yDpnwBweT1fkz/sHaegJK
	 YVP6Cjye4PHzAffPcK1mE86g8gguqHBIlxSRLU0SZDDkiYxl7cHV40xjhkspkiMl7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019811;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1PjUtycGouJlBVw7CED+koNg02erEJR7qDh14L+3Vtc=;
	b=wVzqwTerLvIpyxiPMz5Mp/72oidDpc4phqTrp9Bvwojt1AuDWSN10Xu+NFQBwDWugUZP
	 sv+jvRGx3IjTDbuCdGauCDlHfTZuum8wxj0c7OOM6qxbnnEmax3aRl8FK1vMqvXK1ktQe
	 eBay9jpnHEtoY0c1I2yPiLM3tXHaiS++fqBz0To99uAJ6V8mI7OM/p8NsyxGjWq3HdAQT
	 f5w9TVD2um26tuzmHwYPNwsC70X6P5BJiNhKVqXQfz5570h8VB3Szd2/PwqgFudL/s0nD
	 LsdNdxKi4nE+AZS2J/aT/8A+8NT9fATT0pgi+n98Vq4ShARDUrCVdNTwUMNHuQSPoRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VBJcpTwq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B06606A327
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B06606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VBJcpTwq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF42E25DF;
	Mon, 26 Oct 2026 06:03:26 -0700 (PDT)
Received: from [10.0.152.204] (e121487-lin.cambridge.arm.com [10.0.152.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D893F59E;
	Mon, 26 Oct 2026 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793019810; bh=1PjUtycGouJlBVw7CED+koNg02erEJR7qDh14L+3Vtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBJcpTwqMayv1hZhvTkY9XGKP5YY+XnQV/u0h7obPU2K8slTEiLLEQEUf7ptPdyMO
	 zQuto3ERS2OaaXzvQ8ESDyTOnIPnwrz7twS/kavBwhgjhwPzahb+F3jdR+1xuznHWW
	 dgl1uxdDzv5UaaOF/NXySQpFzAW7AXn85KXDCjno=
Message-ID: <412dc63b-df1f-4748-8235-542ecfc23894@arm.com>
Date: Mon, 26 Oct 2026 13:03:27 +0000
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
Subject: Re: [PATCH kvmtool v3 13/21] arm64: Describe the GICv5 IRS in the DT
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-14-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-14-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> Describe the IRS CONFIG and SETLPI frames and associate each CPU
> phandle with its IAFFID. This lets the guest discover and configure
> the IRS for shared interrupts.

Out of curiosity why do we expose SETLPI frame to a guest?

Thanks
Vladimir
