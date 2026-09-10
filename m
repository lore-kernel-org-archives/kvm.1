Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9834A2615
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050971; cv=none; b=QyajLCN8JWQspt+PgEJDypbuQUeQfykw9GAIt8WKCy87IRpeSlwFsi2Jj3gOltMI00L6oNCGncpb90CACvY8RkI0YJjALHewG92mets69zLPoG250K2gTGKgj7WcWy9nOGiJ36VFGNm8OtyFszrOlGMWbJ4Hk/EH3feUQo9tYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050971; c=relaxed/simple;
	bh=C519sVSPJfsNUw48D24+ejPOXQ7FspwzLtOYq5ZLgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLrPXW8v7zo43xUFJYPUqeuRV2YZyZ4YyA1lU95fw0RmzxtiufZwCdzl2J4gzXwjxlmxCTeI7595Ah6VEn8ICPKqat1ijDwtcBkvBuZoStrMoTPx4GLT/j7SKD1Eyd2ZIDUWGQ/n6oBnHQmsBmKLiwCp60ww0wfOOWlfU8vcXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzyHE5Qz; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzyHE5Qz"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aca0f482e5so7774753eaf.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050968; x=1789655768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sZUs35JrSr8EiZKEgDZvUwYD31+8yR5UTcOb/ueQ2Do=;
        b=IzyHE5Qz5IEAsYGgSVggZNmoEf/+IZab8VLhYZuMnHVLAgNb5N2AXjqgeaKQvbOLcY
         YVJBrCMuT+JlVgn0KcpOawjAIiKphOYMjDrzvZshKt5UgB5ZtguaE/ff524IaWT9I3/k
         6psKB6G9sAsF7f0qr52TupgnSONPBCN2EpRieHRRlQsDmjE4XEhW06AsqjBOBVM3469F
         PBc80+Q6YswayDD8j22nVztgSa1iftjOu+MiCzDSHEmNS8j2ZbM/uQEWy2jgQQ1FAlsN
         XnFGWCOYlZK9StFuUsQrrxyyNiKSjTd9w7tBuVWqR6vyyqnc5uMpsHBKnzqMDFBjavk9
         Ufbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050968; x=1789655768;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZUs35JrSr8EiZKEgDZvUwYD31+8yR5UTcOb/ueQ2Do=;
        b=VcdImbGnEPGqPf5yjRLjRn4LRX9bXe8p4IZEHWvYR6jGiHfl7O/Zh6iGtk1xBrZg1G
         QzwvVEZvQN5atxkkHE70jMyy+o9bAsgff3szde6uSdrwJ+Et0MMFhYlQDMs64VP5nAjv
         EKzSNdoV/+v2n/Wyvv3rujkKbxv12kbaJUsk2UOFrYh/aKfyEQVQ+sMCUj025v6Ycxg8
         nOpnlt4tdIYF/zix+vUpKJA22wHibPN0ATrJyAnyIvt2zBo6pwgxnmU2T7lo/pn+F7L4
         x5H7M1RsLQr0/5unSZUGQJ08D8gFk8qYQbgw5w1SEXevseKWWgBsNcct4y6gmyGT8BPQ
         IaTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3oBRt2Sq/2KCVPHsDnKLqoIBJxOt58Y3y84D+ADLT/0oz9m1ZNvpAbCfmJQk0JJ2voFo=@vger.kernel.org
X-Gm-Message-State: AFuF++nt92x/8Dss4Bb7EemP3LlCw7rCci9ZuSDa8wNVGY1byrPJF/TD
	9XJ5D+xTIjE/HqHfxsPjxzKxzpYL9hv6jaA7qTYg47XttNV1af4lMTTDcVWpcamn
X-Gm-Gg: AYBFou1OHON2fNSGyPAmS28XH01CRf5evtH1cOKYoXXxytBZ9PO3p+wapMwkuYNgb3x
	1WFSh9XOD7oH9s6HTDI+hIt1tDcWOGqsfzo/2KuKVE1IKCyHuoMTZenJtooezmMXZ5eXhJGg5D0
	FNXDgdtmUY9ZWVbt9oa1wP2LkLKgOBp1RkwzQuJtiDqSxb0bmF7imRQHVQvfOMKyXJYn0sj9WOh
	G7I4Q/6CgM8ug7anXklK2Tw0vMxNBCdhYSxikLahEGJvLpQuAbh2jYNx2mLNxpHANw6ZM+EWuqS
	r5aEI6OqHdqYVOy43RjstkprdCH3FVJgXXUUhgMrMnTgpUyB5PbhljCndHLEuZRZLnYdDanpeqB
	vbz/r8+LX66jKZ9LtWWxBWERK59NKq8wIlLdKa0+3YmjvuZIGaKyAzjp1pBjr1Z/eWyv8UxnLqE
	w++gDnLz1h6GAbxaaFzXi0wtcresUX0iw7lomjNdLY8JCx9cw5YSMlrVpfnHLUavKMlpi2IU1vy
	Eu9OCTnnvJQpZSVd+c=
X-Received: by 2002:a05:6820:2212:b0:6b7:8415:d77f with SMTP id 006d021491bc7-6b78415d8a4mr23181127eaf.42.1789050967825;
        Thu, 10 Sep 2026 07:36:07 -0700 (PDT)
Received: from [10.255.206.241] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6d93df1easm18058555eaf.1.2026.09.10.07.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 07:36:07 -0700 (PDT)
Message-ID: <95f672f6-21fc-4bfe-b629-fc4b88b145b5@gmail.com>
Date: Thu, 10 Sep 2026 22:35:57 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogWz8/Pz9dIFJlOiBbUEFUQ0hdIEtWTTogaXJxY2hp?=
 =?UTF-8?Q?p=3A_allocate_routing_entries_in_chunks?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yanfei Xu <yanfei.xu@bytedance.com>
References: <20260908120133.2381-1-lirongqing@baidu.com>
 <aqH6YcHWk_GmJlqF@google.com> <7d6d2449013a4435b71148177820e26d@baidu.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <7d6d2449013a4435b71148177820e26d@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/9/10 11:26, Li,Rongqing wrote:
> 
> 
>> Please look at Yanfei's series and help come to an agreement on how best to fix
>> this.  I am trying to get to Yanfei's series, and normally would take a close look
>> at both, but I am extremely short on cycles at the moment.
>>
>> https://lore.kernel.org/all/20260525035242.107264-1-yanfei.xu@bytedance.
>> com
>>
> Hi Sean,
> 
> Thanks for pointing me to Yanfei's series. I agree that both approaches
> aim to reduce the allocation overhead in KVM_SET_GSI_ROUTING().
> 
> One main concern with using kvalloc() for the entire routing entry array is
> that, under severe memory fragmentation, it may fall back to vmalloc().
> The vmalloc() path can have relatively high and less predictable overhead,
> especially when routing tables are updated frequently when guest OS is
> running irqbalance.
Hi Rongqing,

You are right, fallbacking to vmalloc is not friendly to frequently
updating senarios. I assume Sean also noticed that and suggested to
introduce the patch2 at v2. It could avoid to allocate memory when
the rounded size of total entries is same with previous cached
allocation. I think irqblance could benefit from patch2.

Regards,
Yanfei

> 
> Thanks
> [Li,Rongqing]

