Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A02258EE9
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251269; cv=none; b=BdiBFXehzTFVS0vxM4Oqmrb93NCJHIaeJ9cXdT+OM0/UReVnUsb1m/gJOazXzFx3AOmKf739JOuI8aYLqlwUMYdMqsw/+JIxk2RbAS0E4/RqDzp3uVWUHc+MROO0X4zGqD2zVxEk4akCzZB3sfVR6uhtRjkGeAS0ZVOtUdOXhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251269; c=relaxed/simple;
	bh=wIN3RRdIrorf6IKUtlXJzfcjKC7+FieaRUL0bJ+gGV0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i0WYVr30UxMHU1jJpE5BOcdft557tM6FcsxksodCXyui6zUSm9No9a71bfPvOhFjDrAtH7QTup1C9rXJs6iQvlA2fX/8QB3mVT7/Y8ZU5smf/sDpKaa3FzVGZPpqaeu//U3V2dCbQJZL3zrAVYMrBMfW3qby7VcsvvM0Xl0XJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YblCejKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YblCejKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BE51F000C5
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792251268;
	bh=aLniJh17p0CaayR1NteqEjq6zX0+RmuCKv05/7X3Swg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YblCejKII9hJcDcGekV6T+bIw4DfiV/E7tYLqaD4vNS3F2TRGBr1nw0EsnSHy+9hU
	 Pw9dbmSXKNkKX8+yq2si9CuyahI46Zm6l77/1lFIlnfwLl6PzeF+L/PT75lxeheQMj
	 IzeIp+02EfepJo5Y+3u3PpZ/tji8kEVxs8EMj+PeXmo/zkCLXAzqkl9EDUql3ooyYN
	 W5k3Phf1Zk4KZ1xdcNEN0ohunL7+new/rI20+G5NpT66FMDnOaX/8n313zLxSdWrFH
	 KIUqmhJenn//9DxJRgQO1i3fCNJIapWdNfKYUoQHawX8ebugvwz4UXrgFrg1pO/5Bk
	 Y5DeZ4iwyC47Q==
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id BF2B0780043;
	Sat, 17 Oct 2026 11:34:27 -0400 (EDT)
Received: from stl-imap-13 ([10.204.2.104])
  by stl-compute-04.internal (MEProxy); Sat, 17 Oct 2026 11:34:27 -0400
X-ME-Sender: <xms:g5XTai2DzNI3GZM4ALQyv0_t-T7eOOOK7puJZcp8rb2_X9cigI88Sg>
    <xme:g5XTav4b-U0cK2vkvW33GShYE0_NQvSRs2Y1I5e5ro5uiouaM-jAmRNav9LBv5Wn6
    Hi4keX0XBsxX8hfahParpmm04lDzDkhJJfvHHqmoRWOvbB8V9GxJSyk>
X-ME-Proxy-Cause: dmFkZTGiHggy7nn3oQB25ITjpFUvOHClxj45rpZsyIaN3csOtm5IDpKKjeP2K7gJO2rCLC
    aFHvKohtKDxkqIz5TFz7om/39VDoj27B5N3+ZsBdC9+SV8WXhyspxfnMwQ6/1Y0WjhySLy
    RPgCFmswNIl+b9nMa+B4idJA7hG+AxKe3s9WQwVoAvi+ZCVE49qZI+gMl6m8/a3bffjwMi
    4zYwU6VvCBP5eCJEA5B9O4tmBoVP8TAWfbuqbwtoXuQ9A2vGNMj8U4GaSjlquddAhRJY/L
    oHDScPtPS8xZPRxgXF6rFzFjxqPehZvUNaACzAmQOBe06MLIP/6+EqhNiKgMUrEKdZ2kHW
    lTxC5+0DZOaefU8nN4SSh+OcuawC7wRj/xP8BvjbuaQwgojDG/hHoVuNECJhDWl3qweb5c
    Nacv0gG0ycI1TJ39uXxBpZI8N/YvtwJZjTl/yXPh/P76hjMloPw/INwWcD8WTw3Js6yvo0
    nJl+iTCjSZdWEZxLS9SdmtO2r+meHrkdvk2LFmNTzPJNHq+TntVJXgBDGbJ/yYROPhdb6t
    PZXCP/w6l19ZOpGRImcxDMNhzFAkQIAMCqbfY9+yc2Z9LPqRhg7J/MPoKYHd74Y5jOdNor
    wZg4f/kzTcyMGzKaK1pBUf+PFxmroPVuAyiu0YHMlLvPDc7XDUGX6yIpJ/3Q
X-ME-Proxy: <xmx:g5XTaigTOSUIVobnb3q-mzKD_E9afefD7s4XIK46pEJTciFJ7lyjmA>
    <xmx:g5XTaqaOa4cQmUHS_Er2uCvEWIrvVvV21cGOjN5WwUh_dfT-n-bzoQ>
    <xmx:g5XTavrkyr5n2LHe058CCHCkWL_wtaQWRrGkuwHhKsz8Xh4AtBpaiQ>
    <xmx:g5XTanP211M48afaZAEHoHEyGPhFy2CApjz0z3QSXsDqtIhdqjSsNQ>
    <xmx:g5XTaiqvEjX6OsHIba9F3PQaa5-nL8uZwbNOr5ylwUqWIMc9dATBak4n>
Feedback-ID: iccae4b50:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 66C5CF6007F; Sat, 17 Oct 2026 11:34:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMF-yoFVky7s
Date: Sat, 17 Oct 2026 11:34:07 -0400
From: "Chris Mason" <mason@kernel.org>
To: "Sean Christopherson" <seanjc@google.com>,
 "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>
Message-Id: <ea8975d7-8e3e-41c7-b44d-708f2194438e@app.fastmail.com>
In-Reply-To: <atOCbna3qAQZ1wLn@google.com>
References: <20261017093016.32348-4-amirmohammad.eftekhar@cispa.de>
 <atOCbna3qAQZ1wLn@google.com>
Subject: Re: [PATCH] KVM: x86: Ratelimit guest-triggerable IOAPIC/LAPIC log messages
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2026, at 10:13 AM, Sean Christopherson wrote:
> +Josef and Chris

Thanks!

>
> On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
>
> This, and more flaws of this nature, were also sent along off-list by Josef and
> Chris.  For this specific case, I think what I'll do is combine all of the
> APIC ratelimited conversions into a single patch, flip a coin for the Author,
> and list the other person as Co-Author.  Any objections to that approach?

I know everyone is cranking hard to clear the bugs out, so we're good with
literally anything.   The LLM generated commits might need changes and
might only fix part of the problem, or might have been found independently
by others etc.  We'll be happy just crossing issues off the list regardless of
how those patches are credited in git.

-chris
