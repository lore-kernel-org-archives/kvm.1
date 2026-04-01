Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BE478E2C;
	Wed,  1 Apr 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065395; cv=none; b=VXvKkziH57SSdkDxK8S2G3DkwB7raJejLPyewYKITCfFEq66545tOBqBQNe8CqtP8ey1Beccg1MhLxvgta+hOtnuiGnFJBafzPlnqD4pKVJu0iv6Mc5PPa9khyXOBI3yx+As30KHw6p2tsVCfzeppK2OD/MFOzcsErb6YtLW0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065395; c=relaxed/simple;
	bh=RQfaX3rIxoAuAWMsOV+LQph2mUUgMG4RpJpEAytkvew=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fbxU3Ng6GkaUPl3gVnNevVpCJ8x/MAwNzI1+Q9CMSynblFd6i6VNSlZXKmbKFX0pbQNuH090ZUCvF6ON3tvu0Mb7WrUxkz9cX365agxaVdV6ctYtpqxFqVERIgx/q5HxtMpBCJDnIHuMK0YZF9tZJcBmLRyTw79KdLGj6be/iMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QRjsRAds; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QRjsRAds"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 631HghxP2830935
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 1 Apr 2026 10:42:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 631HghxP2830935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1775065364;
	bh=05q8T0oUE2ahDTYXuGPmOa/CIGpVAlbic9Pl0PJn9vI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QRjsRAdsjQjglzrPySqF6afKGkz4h2atwGcE6RLQBbF+QqsQr/u8HsGW3mH26TTB7
	 GXeBPb9pu1ndXlfw32qXmjL1cMQpW1zMiBIc1xars6i+JsrMuf1vEL1iEB1UNM1Ty3
	 tMuywGOIBp57j8nEY8LHwilySQgCJA4Li7Gzv5jirdLUzYjmD73LMffDHP3bw3Vk+Z
	 RNY+NkQkp9V0vtjpMinjpaEfkGSBiI7qo6GlNpltt7+4DfLLJXdvPAfCBQ1OnJ1imM
	 d29+/KNPm9Muu+EqkesSlJZaMRPSAGFcCiwLi9arL9XhBz29Cejbl51Z4jrc4KbGnW
	 J5b1xJkBkLMdA==
Date: Wed, 01 Apr 2026 10:42:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
CC: Vishal L Verma <vishal.l.verma@intel.com>, Kai Huang <kai.huang@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kas@kernel.org" <kas@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@kernel.org" <tglx@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/5=5D_x86/virt/tdx=3A_Pull?=
 =?US-ASCII?Q?_kexec_cache_flush_logic_into_arch/x86?=
User-Agent: K-9 Mail for Android
In-Reply-To: <830f1e46-0fb7-4756-827b-c8f46af24374@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com> <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com> <acwe7kKyjfEQ0sIf@google.com> <6ad3ff51bbab85147b716de0b1f4e8b994b1998b.camel@intel.com> <acxTBwaw6_xYSShf@google.com> <830f1e46-0fb7-4756-827b-c8f46af24374@intel.com>
Message-ID: <76F29857-47D8-470B-9F4D-DD98D8755EB0@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 1, 2026 8:03:02 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>On 3/31/26 16:04, Sean Christopherson wrote:
>> But unless the WBINVD is actually costly, why bother getting fancy?
>
>WBINVD might be the most expensive single instruction in the whole ISA=2E
>
>That said, I'd much rather have a potentially unnecessary WBINVD than
>miss one=2E The thing I'd be worried about would be something wonky like:
>
>	1=2E CPU offline does WBINVD
>	2=2E Some other TDX call gets made, dirties caches again
>	3=2E tdx_offline_cpu() skips WBINVD
>
>So, let's just do both for now: Do WBINVD in tdx_offline_cpu() and
>comment that it might be redundant with other things in the CPU offline
>procedure=2E
>
>This really needs to be solved with infrastructure and keeping data
>about the reasons for needing WBINVD, not relying on code ordering or
>fragile semantics=2E

It is, *by far*, the most expensive *uninterruptible* instruction in the I=
SA=2E REP string instructions can of course be arbitrarily long, but are in=
terruptible and so don't really count=2E

Some MSRs used during very early (pre-OS) initialization might be even slo=
wer on some implementations, but that's not visible to Linux and no workloa=
d of any kind is running=2E
