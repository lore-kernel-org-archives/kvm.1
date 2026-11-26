Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697226;
	b=5RT1UCTSZR3TpI1nYapCfv9ZlMZkCiza48ydtqMd5BLMIQOW/iM+P2oDLs3ZA6xYzIdF
	 RIiSvmr+AH2UtBHNbtnSpV/nS/SeJviTyo3hGWCIrgmSd3UWjsTKAJmgRj0jCXhUUERva
	 nWjrid/XxZv6q4UpztxqBQmntITaSJrgkHujlF8+SMWGLWu5w9x+eP9xxT3wXNQTemRix
	 e7Atw90H14OFXeIVINzECNLKi0hD3W211r5hafObJQAwbtX0GL/p0mA9cEu0oJTG2SIum
	 0yjP//RJ8/NG3opk+AwJ4DcPEZ+8X4/g029k4xIsvQzmXLs68R+Fz2ql1KhLs+oczfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
	b=WcD9ViHipMlRUYgDbs+IyXmf33XuevwZofXlHZ1JfEPGLH1u8Has4ScZIaN/nlXobiZG
	 d4cPtmdfwce+iNsvOl68hkSRxS8bZNm2Y8n6jRXFkYRmU0bavvfUfXIAR12RS8Gbo7xpv
	 SuzDRyNrAxCJ7/SZa/RjDVEgRlWnE/vn1P2xoNtDiJMPq3Hzo8giOS8vbGBrBTFSyvmTR
	 GkdPmPoGNempPyzm44XaRTNAJpha032z7tqd1Lv/8regZqOplLhXD/XFmsK7uB2Cd+ufS
	 hcXSRHDRGUg/S5silPQIqe2B7MIBDbYhRQ5T66/eqN4ScR34fNdgqmLocZ56/hbgUXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=EQ7J7XaI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6BA606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 12:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F6BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=EQ7J7XaI
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d68de53053so5127491eaf.0
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 04:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795697225; cv=none;
        d=google.com; s=arc-20260327;
        b=tDDHTOXFxVSBhQKtRT2U0IZ6GwfrcdZfdGmki57Up6WIwPztJPtmgeTU1NDgRVS/Yo
         lvrXGk8TxGB/Zb91H0k1ZREALBwouq+5iv0Bal/k+VFewvfIvm7HdjHn+WGEGUmMdd/c
         uJbM0x3DzSvCZ0xDIzz/X6h7U2ttbODP2vTRkN+HD13hUBxfmSkibNbp7kvZ+dqNNI+R
         wt0tNIwuLch+eq5lq/SFzQk+qhFchajAhpXzIOsDrlA8bYEFVhfXErSmm16oE9pckX+/
         zwtFoCA73iEJZmsLGHvVoIunXzy7Eb2bC0xrD2miE7RFasurGcz5F+eXyt7exc2RQhNp
         ni7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        fh=mu+y2IUm/M498Z8JSTouUBTcUeZixhsTGN+wf6uyNYs=;
        b=NMispBRJX87tsuRXlTdaTAuzrqT7pMfxhT/cuPRdYkot1IrmCGN0/yWcbneNVBA/IA
         eYb7U601eGO+WyMaRJR8xTTgRZRsWM7BehRnF2f38neY2B9ZIqKRO+V05Z9WQiXlSOQZ
         dRgIHR35APgzDfVHtkIBaqiFo7IoX4kVjjHM3gxHWrVSPIVOTY/Vpzw68V1zFm1ZgQ8O
         wapFZn1mFu7ce+r0Kpp/vP+fIWCi8qed8hgJ/4CxKGQ7rGu6HcLnUl7oFKYUg3P25K0J
         +7kGYAgnJeVWwy3z6bVMwrlD+913YVEVnbDRXiEGgCJ7hAxE9zysv0W0MBhBe+CAiBl7
         YWcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1795697225; x=1796302025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        b=EQ7J7XaIadF3uAn4gbGhDW9T79STu0JpBcKnGDPwJMdcYfp2vzoJ4A3jFOxtwEDQqp
         dojXRykuli4jE+05IotP5k2+v+UoX3fCRGvkQg1TNhJMZWlrqhOPq83sBJicQc4pFHt2
         /cleHU92klXpCLQCARLmfaNbraGAaItzY6T27iQIKsRh6G8Yf0L7y+PYNwhxGG42LuvG
         YqEIdtE5gXippnFoyU8kI+xk6QL+vl8rwIzufLbB1GrLfLqKbuBo8Zek4uVaddpq3xvg
         LuYEULMIbvaKfNsFn1u3pvqDrcI+/vEqpPxHzAIRwIIMCSNRDGj5FS87s4xkEfqOdC85
         wZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697225; x=1796302025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        b=PKlvUPcNch74bKPokZBvug0s77Vpypab/w8pwZZAnLammzgeHj5WSi+l5RkwesJONd
         YvNrbhBLGJixRBlTvdFDvjg/Rx+E3xn2LPZyyW34wbeh6EEtINK0KyOqMUGThPVFJM1l
         vkqTMHeREatwtQp+iJ+vYXqnucUVSbduGIKPu/Mfe8KhbzhbWS+y3cCNyBdJrlcPVKZp
         6bGqQLobhIOOm0bmONVW3tRuERPjwIuEe6FeB8nIR01Yvq0+vIOg4yZ8dhaAZ/mnbBqu
         nzMA+BqOBZToGsymqScHu+44vE0PEL4S6XGFTPtA1aSjlHtcTBVB5h+K7tJhC+yV9x17
         hE6Q==
X-Forwarded-Encrypted: i=1; AL+hErFT8IVAEJEVm9NKerz2niqMer5C/ycoSN0iCVZrfU/Qqe5jkAigYhnYRIY5h7Q6KKw+vhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SKmb4tvhOJlaii/WZK+hikJVypuUI2sIHClzQp247dI5mkxs6
	Yh3wUQu4aF4mhwLCJBfj1tpcyIEwohjlHhpMi4z0jYt+0mUTUFqALNlOSqwId2ysc4r8r401i1X
	u8fOcM0pnEVDzELw5BenfqFEFLRWavM8ooT//0e4xfw==
X-Gm-Gg: AZFdTZdbqKzjxcuOy+u80DH8fNwZsmhDL7DBhJF4YWTHkS40QYf7AJrlhcb5yIj7vCh
	ynbswB8Y0FZlUKjaqE+7FRfIG6/+cO3SCIP1JKWKVEjup0oV2EDVABmFFuE0oX/eaZZJroZIOjm
	423fVEGYqyEKh9w8ePw+FwVo4db4KEknbudiJwYchywBc2IHEig0IWdjkHBzel029no+IGj8OEA
	eS7Ohh0n8j7eeXpGa8E25+RNxh/LWyTosUVjwfezBk7fEe2W5dqbYl81u8SeXwcqCAi/AVogQOv
	gXQ1LHffNCQWh24vXF2osafhyyT+iVozMkU3qsGSkjerAA6J/tJjJJuI32BU0uLB0i/ejbanhwT
	Vk2DAjRD6Iges1W67eJBeKcpgAXi453YLhwLwscpZiUmuWIfgbkE4JaayGEfAEaiyoOSolULEdR
	reVCsgUVo9YaC5hSdlhB6G9tlafUkWcZMTkp+1U4Sb0KsrYZaD553RWT5BATmCGK9y6N5hvNhz
X-Received: by 2002:a05:6820:55da:20b0:717:da:ba2d with SMTP id
 006d021491bc7-71b3949694fmr12426690eaf.42.1795697225084; Thu, 26 Nov 2026
 04:47:05 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
 <cd7bd4428398413e16ff214fc46f5d65076757d8.camel@intel.com> <436c641a-9d35-4695-b41f-547c46479a5d@intel.com>
In-Reply-To: <436c641a-9d35-4695-b41f-547c46479a5d@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Thu, 26 Nov 2026 12:46:52 +0000
X-Gm-Features: Aa3M54qbjy628W_XZiCsTaWPDZAxjlqcXQ_RCIdX0UR7G-Q3f0Ja4RKHzIf02Lc
Message-ID: <CAKV3HMNoCbBeyAsH-UHHC2wWm5fE7ps0mo_E3TKJw0Vk47W43g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v4_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On 11/26/2026 5:42 AM, Edgecombe, Rick P wrote:
> I think something went wrong in the send. All I got was the coverletter and it
> looks like lore did too.

Thanks Xiaoyao. Rick, both patches went out with the cover letter and
were addressed to you. Lore has them in linux-coco, kvm and lkml:

https://lore.kernel.org/all/20261125-tdx-guest-quote-poll-v4-1-d89f26854b88@flashbots.net/
https://lore.kernel.org/all/20261125-tdx-guest-quote-poll-v4-2-d89f26854b88@flashbots.net/

Maybe a filter on your side caught them. This pulls the whole series:

  b4 am 20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net

Happy to resend if that is easier.
