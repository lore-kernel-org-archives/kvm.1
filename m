Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233D345CBF;
	Thu,  6 Aug 2026 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034198; cv=none; b=X2GbjWgWIIkA1+/eIAMjmejyNXrq2oEQaAobsdwJR4vhMYAciHTGS+OfH60Ue6dGkdKk6Wzww51Pmh72aBDbCivJR3uLixEAi9owRsVXa/ePDfxRoFohGauhrPNEeVo1cNF+AXMYaXRlYodTauR3R+kON6kdssD+K0HJv6WF28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034198; c=relaxed/simple;
	bh=sRdRPD8g3aRqE7KOzs3ztuYv8xFcGuz+Rx+4mNl0k5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dselPfa6WX1nY9L7BZY90Xm+DDuuCSkEu1tGDKD1LAGbz/CjcakoJhqpTRczeJN5fkjcDB43YStffXRKFS0fdBY/IxzV4igJTzpI571N0Zr7c6utIInctb+QiY/ywb+sNyLofEvleKeISiZHOf72CDLmAZzjlfsBjf1Np1nPgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2tNMIwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2tNMIwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276711F000E9;
	Thu,  6 Aug 2026 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786034196;
	bh=dYgTROmA3S9YYxoIX0RnvvNWtlrrmgkIbAsRfNBVPWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W2tNMIwEAfNCTwDDnhL0AFQucPE5sv85OfGCC5ymuYtjo8GULNbbUz0sRypf8w/Hb
	 2wUIU99yWex7ZwO/wqqjm1+lQxJtFRF9cn/XlibJHtYd7gQqvN61fC9TBx8cFl8Ejy
	 Nb+/TZJ6cpRATbqWrcXFyTG171V8vI1eb6kTf90x3qJ73U68vo7ffd+ip0vQW/U83+
	 2Jj+qC6v4Y3zYwtkBToz2v49qwTjn92dDszm0ferAxlrCm1IpXR0ONxCXUJjoEKeNx
	 P6VXwozmDt/s27fPNPoEgrGIAZ+8pR7V+eQjbm+SxK+DYsuaKWjaQF6jZxOO+L38qU
	 KMaDmaySwmZag==
Message-ID: <956a07d1-8f70-4376-9505-623db0223479@kernel.org>
Date: Thu, 6 Aug 2026 09:36:32 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] riscv: Maintain epc on misaligned emulation
 error
To: Nam Cao <namcao@linutronix.de>,
 Charlie Jenkins <thecharlesjenkins@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
 <87cxvvd4o4.fsf@yellow.woof>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <87cxvvd4o4.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/08/06 1:38, Nam Cao wrote:
> Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
>> Currently the epc is set to zero when there is a misaligned emulation
>> error. This will print a misleading error message with the current epc
>> value of zero instead of the epc value that triggered the emulation.
>> Avoid setting epc to zero to maintain the state of epc.
>>
>> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> 
> I see no reason why epc must be set to zero, so:
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> 
> But to be sure, I add to CC: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Damien, any reason that epc must be cleared?

It has been a while since I touched this, and frankly, I do not remember at all.
As the original commit 956d705dd279f says: Code heavily inspired from the
OpenSBI project. So I may have copied this without thinking too much. That's
likely Anup's code, so maybe Anup can weight in here.


-- 
Damien Le Moal
Western Digital Research
