Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04248987D
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352693; cv=none; b=XikllmCX73PXYI9fIly70RWx0tdV9ND2+tFn8C0FJRi5JaGnluKgsYKlOdyqqU5Ahw3Rj+D8u38D2xw+8CGjAygk5WZ2GNrCasynDHBnpR0KHmOfJGpp9Ofo++zvos/60+X8TWE4V5cbNt2BrdN83+xmvWUs2fZCOwal1tqwN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352693; c=relaxed/simple;
	bh=toApdj4I1WoUH7KR7LeVlX9o/7F7BrkRntzeWihmuh4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WUv3KThakA/80qKPneAJP4EcpW0oF94lFAiYbZUQp/DWF5dggYHmESgyhJaedeeAxDRWjKXtF5Uhs6OVnjO5GmiSFbCGp1P3KQrgiVFoQVym2P/Sh2JVYV5eEDeBW0cVW9YG/ggH/COu8C08WywAOiv+Pwb7F42pMG/CAHJi+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO/PQNgj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO/PQNgj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c259e5c22ffso159450966b.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352688; x=1788957488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AYkjcJGHKzFzldZ8xxaJoV5yW/xtjtJFf4Yz0okljGw=;
        b=ZO/PQNgjRz8Soi/7iAkdWF8k++gelAaafpCNNuyHvLKItSMLaFb7w1/5Ghf+iIFPgH
         WxU5Et/WyfuCdhNq9vSjdqdeSUxdUn2mXt5iSDeWf16eiEEP9shkL8WfySlH7GJ8CaZx
         KqACYqifW3D10+p/cDw09T1J77+0O7xUG7cqgL494AAnWCVh2xPCPukJqxj3LESRFKAp
         TlY9Ps8SYR+tKGSlvtsXnORzpTgCO0kq5mxdhb+48bnH3q+Xn0RZnwK3JiN966MK7sZO
         1hZvlqTlN6qWAq8GDrpGCtbPHhHq5qg71uKdUXgh2f4FPY3rl2GgyDrhG6iDz/7DZM0B
         rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352688; x=1788957488;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AYkjcJGHKzFzldZ8xxaJoV5yW/xtjtJFf4Yz0okljGw=;
        b=PAQcOGjZ8Vu8G87mP4phacFJgotKkAJJqBqgT9o9aCj3hSr6zLWXPPks5PNUmkJTIW
         9EnU15eINasf9EO9Lb+p8CcKn/SP1CORnU0/Id7EeAWWZfDsMClFZypGaVr9OOhcuktJ
         MFIi3nmKjBWITWWCYXKIXxgtcYnW1Lxsf3WoP90bxNxs6htjT2Wi26fOwNltA//5MLgZ
         n5oybFti7rlqVo5gEr5P6KanVbHLpAUmZUAnk9Wpq850OwNXPk78GBHn/4xx8bephmMi
         aAeaqN3UpAZdR8rDnE9bBPjFskfljZ8sqj/ya0jKk82oUgFOy/EoqSz/EvIs0xSYk5yD
         iMnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw69u7UNOcSYVBJYnr+XsrcT+JLH4fcSf5/qnUcuFV1c5show7FPdRHku0cX9osXcJOCz0=@vger.kernel.org
X-Gm-Message-State: AFuF++l705LlU1QTZPmktmJchCbn2Ui+zvZ2I68uE584uLimXxEqGfFS
	iV3+bWuDmk176Ft+gwE7VmfphXtr59LWP1TiPfNF6OBUrWfEYPyMnWLb
X-Gm-Gg: AYBFou2uzyCGcLOOVolpBeJwO+XjewEJgN4SxvSeklioXgnYlwu6hNfeoXhL5mAkXU6
	evvdKKS7KN4MIn4Yj4V0K8vM5Wl6C4mYcBg0ECFXLurw+VWH0c5K4DJhvG0LZbe87tzQ4+/pT48
	O70KI1b26UMPJ49Uz36W+tm7NKFtxONWjZU3pSpY5iVzggR2txG4DbMgVVvt+3q05BHWvAL+lwf
	42FtDf7j0rohOJUyUUXX3cftbZdCuf6SNtvDFa4btvZ3xY9lBTkemBK0vj1U0lPy340lhIh4uX3
	DhZmByziLpKKn1AzZ/UpRcgGDjzpsslkZzR/5Q0JLb1Vrc9PVfRUxiNNbRzZO1QbUori1Mb5tdb
	ZM0z3UtwN7rt4N/xYOmJwe1t2dbWry3bDpEvrT0MahtnttEX8DgM0k/jt5Ll58f28W5t/NJGRgv
	dA101Dnng5i3nPJ3ZpYe39ecnC9SHD8b8kRvAXhvzSWsxdLGsnxsu/MnhDKLtoyaScZQ==
X-Received: by 2002:a17:906:c145:b0:c25:8e4f:edf6 with SMTP id a640c23a62f3a-c25d529225bmr308336266b.1.1788352687577;
        Wed, 02 Sep 2026 05:38:07 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.2.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d041ab9esm122624266b.53.2026.09.02.05.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:38:07 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d6c51d34-5fde-4123-90ed-a37522088448@xen.org>
Date: Wed, 2 Sep 2026 13:38:05 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] KVM: x86/xen: Use 32-bit atomics if vCPU's
 evtchn_pending_sel isn't aligned
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
 <20260831213632.81023-9-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> When propagating pending Xen events from KVM's "cache" to the guest-visible
> structure, use two 32-bit atomic operations to do the bitwise-OR into the
> guest-controlled structure if the structure isn't 64-bit aligned, i.e. if
> the guest registered its vcpu_info in 32-bit mode and then switched to
> 64-bit mode, in which case using a 64-bit atomic OR will generate a
> split-lock #AC (if enabled).
> 
> Opportunistically isolate the clearing of the bits from KVM's cache, as
> that structure is KVM-controlled, i.e. is guaranteed to be 64-bit aligned.
> This will allow dropping the open-coded inline asm blobs in the future.
> 
> [dwmw2: Cast to u64 before shifting; evtchn_pending_sel is unsigned long,
>          so >> 32 is undefined on 32-bit even though the branch is
>          unreachable there]
> 
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260604193554.1BA311F00893@smtp.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608071502.rYOi3Pg8-lkp@intel.com/
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
