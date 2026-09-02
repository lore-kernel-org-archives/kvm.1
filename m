Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505F46A5EC
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353319; cv=none; b=gtB4HbOO8oCiohglCjKhD8E2qd+uCWvORDvtenHzxg03nh/GkGrV5/jZ55a78YP5p6berZ41yGeZeE3X08JEzBmcMI1ym8eZiorSAiQ+WFJJezgwJKLAUD2ONOJptFcDsRotiGxIbLane7PVyX8m5xrmEIsVZUw481LiI4QjaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353319; c=relaxed/simple;
	bh=BmpaVXqB4LM+Rf5r99/BNRSHxyeiPfZNM3L7O/qYlZg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dO0EEAmJwpQ2CuLWOc5o1RWWFlbVnI2pw+c2v6WIm6XPk+kr9MAksqqxx+TVleiNzDf0vfQeVDmqTEhqJrxsOPaw52m8cSZfJ8qPko4MDi0+sW879YPvhjahwcX4Ftv2wFNgQF98CwHcfKgT73YbZiRMo8nn5vVufmJIjyClp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHKQ6fuP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHKQ6fuP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2020421077so145505266b.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788353316; x=1788958116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xcrw8Slwvqfw6cD/yOIjKivNvmSVLpGL6BhglwyY1n4=;
        b=IHKQ6fuPoY22UNfMtg46yJrF3/7gGqrEKKTnev2A5dMf+R6YDQ4gG0lot+6I4FSCne
         cfZlDfWIvd+CnGKNpFdIcuUJnS51dXFpJXIzKkOudOd4tNuTO7OZr96KV+y8WJo4PpTf
         BlciikAwmVD8F5cGoIPr7LUP7GjM+vlkJyJDxfUk7CcG4REBiyWcFsCo/jS2wXSPbzjw
         4hBmjAmWCjGpuJV9djHj4W+fdD63vNIvz2vwZbLGWv5kHaVHY3RVDnRs+NtCpL/dUyiX
         EWnusv72ZkZ3B1wETeu2XGGxyqUZUOLc5SHEbsY7bhRJLjq6sM4schb1hQFvTIkoJsik
         pgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353316; x=1788958116;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xcrw8Slwvqfw6cD/yOIjKivNvmSVLpGL6BhglwyY1n4=;
        b=WqPtlT9urtXhpa1CdUateq/9EKs4os64ED4iHYv4byy0ve/nzo8ALbTJJ/aJBxl2lC
         k77AXfQt/kYaYuow/DwUaMJbNNHzOXSZIdcANuduidEN/pzSKvj/jZAISX0rk/5/w948
         9pT3JqgUVhX6EOJEj2jsKeh3BsdAHKXtXTQ0TW1p2gfQ76htpAeUI3IipM6oG2Knx5dq
         G1R8O++p7MFCLs5GEfUMFt/plNRfo0T/dT+7YxB1t0zmU0cyhuON1UVkFJL1S6JnwKPM
         7VYXNrCwdIuxEL9Q9lIKdMD4mRMvKbzy1wsaUFzllIkbf/fwt4Ib6LCEv5aFKJi+XBk3
         mY3A==
X-Forwarded-Encrypted: i=1; AKwUvBwXcrAVdxyc6Iy2NHHlS3ZIp4lxWL4dnNueAMq1dIFY4mg3vlcPM0Ew9MWvuhVwvY/6rlU=@vger.kernel.org
X-Gm-Message-State: AFuF++k74RFZzZp6FFvGT/Nu4tq3USdH7DVOV2+Yt68AX1KBdrWYLK61
	nhTa9Ecdlxs7i1fygPd6i1KGRtVLD2gAK7IKH4BKGY3AW5hTtPPpagM/
X-Gm-Gg: AYBFou2tC+wrRYqwQSCpMoZIv1rKC/oDkAW6vl/zT0tiQe/NH+c0Ml3r6F0vYcn8Zrb
	CTkhaOGR2s3cyWxCy3+gfOk9Wz5SlruocrdjHfMPbjY8YNT+Kpc/XL8k7C9QmyNkRErCZwHPQ+4
	FnzUstb2kV7RbF0JUfz+8ZQM0FQuG6n6RYIXyMnXLwOF8DxjLL/RMEHExVZIURTlFN0Q7Ifgvul
	kdlcFXN83I26f6/XVVMUpj1KlCiGHvPCUieAlcp+VztloMgvggiLpa/3EXUfaWjprdCZ/9zapMC
	Uuhbo7XYxFyDSW1nyzGr1IgMJhNodywrz+YCWcKOHiN1hAIvUSrLKxpcNl84IxeztqDHZmKf+HN
	ahxjIdKq8Y8q9kTEgmIU9ARwxw6Ec2yXpOHnDs2gUQQmojun8yEQGCfEsJVPXjczk3uoGVQi8ao
	kcB0rJIz88nzh0PdIQePXzSZJHOaQAHPvZp15AiBP7Fulr6ZX5NwSw+gBR2EVQkwua
X-Received: by 2002:a17:907:6d25:b0:c1c:4e36:eec6 with SMTP id a640c23a62f3a-c25d54f1adfmr272346666b.18.1788353316213;
        Wed, 02 Sep 2026 05:48:36 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.3.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03fbb75sm126078766b.49.2026.09.02.05.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:48:35 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3ba65a4d-1c68-4518-acbb-893485a5dc2c@xen.org>
Date: Wed, 2 Sep 2026 13:48:34 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] KVM: x86/xen: Convert evtchn_ports from IDR to
 XArray
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
 <20260831213632.81023-14-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: Furkan Caliskan <frn1furkan10@gmail.com>
> 
> IDR is deprecated in favor of XArray: see
> Documentation/core-api/idr.rst. Convert evtchn_ports accordingly.
> 
> kvm_xen_eventfd_assign()'s single-slot idr_alloc() becomes
> xa_insert(), since it was really an insert-at-index, not an
> allocation: -EBUSY replaces -ENOSPC, still mapped to -EEXIST.
> 
> kvm_xen_hcall_evtchn_send() drops its explicit rcu_read_lock(),
> since xa_load() takes its own RCU read-side section internally.
> evtchnfd's lifetime is still guaranteed by kvm->srcu.
> 
> xen_lock is left in place: it protects state beyond the map itself.
> 
> Signed-off-by: Furkan Caliskan <frn1furkan10@gmail.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/include/asm/kvm_host.h |  3 ++-
>   arch/x86/kvm/xen.c              | 34 ++++++++++++++++-----------------
>   2 files changed, 18 insertions(+), 19 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
