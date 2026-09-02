Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156C403E9C
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351951; cv=none; b=Si0xDAcz2lPKRHyMdR36U5fcFGN7db43uc55d+W3PUKpyhFzhPtNcfc6SA63Mo2MWsilRJodXy8os6wJFjF/MpHuBtMj9TF2fObq3/2P//GwZXFBZ+Vy1sOZ9l2X2shZSlVzezc9XG0b8zEZUFsEuHD6uQJSJojkOzwcGC002zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351951; c=relaxed/simple;
	bh=qWim/lIPPQ6l98wILRuoStvmb9qBcy2G1Hm67Al1zOA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3lXYpqQ0ynQyZqbzvpYxt7hFC79wb7mzJtgqmKictogHkbhH9vehSMrdhYjAbVwklwAdQiso97LTY0AuN2vJy61mMDRSMzupUG+O/mbkQ45V1HHdNlTy9umSnG7d08W+cSxWkScw4HPh7tQsFMdYMaC0yyQr7lI8HIkOHT/0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOEruDXz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOEruDXz"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c169ae1cb26so350512166b.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351948; x=1788956748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WnwKUYyG1eYkPaem6py7c8DPLUxuR2hx2uAC6F2MPOw=;
        b=GOEruDXzWTFx4Cbi7NIqyT7+GD/SiamD5kgGg3wA2OwPpNQSzv8xfvp7uJuLLf2y+o
         2MtIOh8pUn3AED4MJe7eo0ibP+6EpWQICKKR1vKG2EZrK96wEvnUf1KHEkEZN1ZFBCjW
         doQ7W8zAFYiAAOvWyZ6yxiG1J3iH3UE6Z6B28ywMyZjqGkKMEy1C12dXt1P7R/M7m8uv
         XnimT2UuV6FKzWsNCjlYoAxOHOD8/ir52S3122BQsN7gzT8an8u5TEDVBeO7IUI1OEzb
         W8Hvom0Nx7tkwCHMVU+iQ3H0ueyEkr9+mOnq7+ROi+EzAwsRqIlscM8ohLKMJw/4Uwta
         bq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351948; x=1788956748;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WnwKUYyG1eYkPaem6py7c8DPLUxuR2hx2uAC6F2MPOw=;
        b=kybDTLMoGhKE+80G4/DXG+Hm9WRaK1NlapECe3UpgNeCzNo7eLIAqLpI4jMo7+fk7/
         Asq78HqEJMRgykq1QUQ6ObIPuU6A8c7V6mytRum6ehJiriUNoaUAT3hPyyY2yED0cXk5
         AnRgpakEtEWSBik4PMbsT1L3iwFOlBUJpwHqToEmieqQHuVr6UwrcXuq1pYvIIC25XYl
         kDJGDANTKK8q8bayNA1YeGO5A+XowBXyQKw85X9QI4WWsLkTUTgkWe6SbJR3DL0wJLWu
         N0PxuhyKSJ4mu6pT2W98oslRuExOD7zZ4LfGIGgx+W3BUDuT4H/hQ9KLGpMKdxyZSjPL
         ZE1g==
X-Forwarded-Encrypted: i=1; AKwUvBwddRTN7UVEGzVicKAuJVJAU0/OlJmCW+uOQtED4yieRhlFZui6SV3cV5oafyrOR2xT77g=@vger.kernel.org
X-Gm-Message-State: AFuF++mKM0p6rDpirfYCLKlKVEZMG/a+ifgCPHYytuRgCYb02DHeom3S
	TbvVycq3v79VDQjkANTSTdXnzj7dHa94CYwIIoOTsVyOB0NRJhRHD8Jy
X-Gm-Gg: AYBFou0rBbbSD4bjvjzeQr7AU7gP9xlMd0j65EmgOeUxHKbLwXUxxu1g2ZMdRXhQx1K
	y1HyD/EsJBhIqrFD1aXF0nJd4d9pKk9CePA0I97nkBdEY8EDSNk6YY9pU28qkgr5L47RDJ6MazA
	Rr0yfbYUqN3Lc9h2UgA79R6yQFkYNzM+0Gi2ygHqO5exc9N3bkNDQx92/Y0ObtRLG+bYXiAc7/S
	SMt9VYb0girj5OZ0g3hQHmTUuUFUUba5OTerEpnKQJ1vllsz91KeUNbui38+w452L3KC0ouzTPb
	FW4Z35draa6Prx97Ec9BrXFiJm/Nx/3VQKMma7KllKkR4hnmguAyUWjsul2ayUHO4++7OU2iwj5
	yGAI761GDpVhRBon06QbVFx2AWsSSoprs2I/nlAcNmSLjd4C5Ge8F8s6Oqr8wESZriiZdUCWP3L
	zbMuvrlyBVL3yYnt+kTadHc07VpldGM1JV7aG+/OMkPduwoY/dWWP+2qeksOwoVRAU
X-Received: by 2002:a17:906:730e:b0:c25:c678:ff80 with SMTP id a640c23a62f3a-c25dc9c1306mr204507266b.2.1788351947624;
        Wed, 02 Sep 2026 05:25:47 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.3.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d043e6bcsm125254366b.61.2026.09.02.05.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:25:47 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <567d5476-5f9b-435c-8884-8ee5b9b26966@xen.org>
Date: Wed, 2 Sep 2026 13:25:45 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] KVM: x86/xen: Latch shinfo mode in
 kvm_xen_set_evtchn_fast()
To: David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
 pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 ankur.a.arora@oracle.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com,
 nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-5-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> kvm_xen_set_evtchn_fast() assumes the port range check in
> max_evtchn_port() and the bitmap layout selection observe the same
> shinfo mode, but each calls kvm_xen_has_64bit_shinfo() separately.
> If the guest changes the mode in between, a port accepted by the
> 64-bit range check is handled with the 32-bit layout, and
> port_word_bit falls outside evtchn_pending_sel.
> 
> Latch kvm_xen_has_64bit_shinfo() once on entry so the range check
> and both layout computations use the same value.
> 
> In practice this is harmless: the evtchn_pending bitmap is at the same
> offset in both native and compat shared_info layouts, so a stale mode
> just results in setting a bit in what the guest (in its new compat mode)
> considers the evtchn_mask, wallclock, or the arch_shared_info fields
> which follow it — all of which are in the guest's own page. Even with
> this fix, the same corruption can occur if 64-bit mode is latched and
> the guest switches to 32-bit mode immediately afterward. Like Xen, KVM
> makes no attempt to *convert* when shinfo mode is changed. Only the
> wallclock field is updated in the new location.
> 
> This fix is for internal consistency rather than correcting any
> observable bug.
> 
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/all/aiHPPUk5DY7rH-zL@v4bel/
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> [dwmw2: Rework on top of long_mode/has_64bit_shinfo cleanups]
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
