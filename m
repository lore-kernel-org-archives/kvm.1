Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA63A16B8
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271060; cv=none; b=oiTRVVg/GxD0nvtRykYsbypuKM7LyAxyxmBu5vV89UlqW4coYDhejqZcsgbOw+HG8NE73TcJmM7I+NmbeCHsiRKpTW1C9ZBBovzg1wJADW/DdYT5skvRii+1vlmX+OwgDXgXPj8bl4YDvd0Xr0CrgDrEuqpMMMfdnfQdT2Idzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271060; c=relaxed/simple;
	bh=SSaL/js8O/pTdidpxKNeWUGD5hSN+aIWwSSGSr/WNMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCNEL/jwGuf1LJtAFP34qFP9Jq0zy7RhhaNh/RLEM2373cMbIWN4jK2GcBBmoG3ho/C9owFRj2A49R0/ODMsY0RJetR/Gd8OCpH6fzKN1xrk8pp0uamdRi6LolhHJnxXwxqI+Sg2ntpbNcfdxZIb4uZfpmtLJwoJl/cJAT657Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enIjT4Zt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enIjT4Zt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1183585f8f.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271057; x=1773875857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0YAX8de4YmYeIq/8WNtylATFHnJksgOAf2WopH1Q00E=;
        b=enIjT4ZtxLSHMPSGI6q/1r3iJP08HPjesosPmf48imqkOcXDJPvCQW9n8IlM6N8eFR
         7k11Dnda92QINvdu2cVQz6nqLxf0nlOmhb1WV8hEBPAO7kzm363FWgXRR8VWjM23E8Ke
         XefOhnDNB8RFjgxQ/byzCAtTSj5Yb5WdnZbPIFoshvlU5+cdhA79RO0jaKOennxHqhVD
         zHZwIPgqW8atg/E60e8EeMxAGiXeR/OvqFM5dzlOV7BHGoSokUBSngKu2XK/otG5hKED
         zcyf6qAKqtmTZ5Q/RZTPkvJgsbPpdgFM6njHzLZxXjdmClfkgiy5ehgc64J9/6C1qMqR
         Qb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271057; x=1773875857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YAX8de4YmYeIq/8WNtylATFHnJksgOAf2WopH1Q00E=;
        b=L8bt1yFYFezfDfmYqZHbPo3U0kdQvaaw0/im7V3lA6BUq+rmBj7Ul2RSUTTheufc6K
         YrKC9CE6lxzeXKyB3byGR0e7l3BSDOSIJCKR9eBGOjKjBp1+hKvY7nljNRZjMZ9oRBm8
         rf5o1pO4IpU3newoA3lx4NQ8Wb/8OIRkKwNkTh6MgFKYaQnnzQ8RbOhjqtI+FCqv4Iwr
         5VP0P0SEHe5g4SpWn3OHFb5+sNZQZqriSmTqsuHaMNdv/DWV7EejEI29Eh8WcO/K+yv/
         671/dU5AqvXaVg641H0fyKSa8VWlEMvBaE9zMnZ/PTtHG7OHr2IyZlk+2j2TbqoUkeQV
         sXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhdcMWlI8cef1hmrK4UlQ0UYQCn5K9Iq8yEncaHlfKb9ilAbXTElMTgeRZY/g9hqbGYvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dW+B60JMUIq4S8Zhi4rCDiBUnZf/q03n9P7vTOyhTwfzAyhA
	6q3//eyI0Pl5behztI0BdpTJhavC7kc8XCPDQWGtA4uGPcT/Sag2utTi
X-Gm-Gg: ATEYQzwyJOn0ywWK3lTP/azV/iUL1dyN8ObbvkuVO8LJ/6DJq4S7Iu4GU9EGOMZF8OS
	YOpxIIcGClYDGOEo40aIYNbJj+bDLxQ4589nEJ/ccYfeXpgZ0aSJYns4VnckuZUH/vhQ5iYTY4Y
	W5mwUhKIvUFukHdSN+EiHSe+340bsqeyhiOD1e77tPQdHcYoS/m7T/L3oUuyKm0lPT+JjwtRcEX
	s6yPqqRfugoqDw8qvo5/i2ajVhe5+Kz+FySH0uMhDf8I1/KmqsMGXdRm61uwJe7x6XReSDL3D2M
	yIrjAX5EcwHs0hvGBcSMfdA208pCLSSUGgfF4m/+rMJBZXOBShmlE3Xx2e2/k6odIvgAn27AZtA
	mHP51vRlhUqSmIXGfPpLSFsy2DfoanG2nBntmiz1eQK8awt7ABW+6rtprahYY8kg8rMJ3SkO5Ll
	f8x8Yk97pT608G/G3MgNGXBYTIziY/VkxqhgnfyhDf7vFXdwQfdhte7U/KHA==
X-Received: by 2002:a05:6000:1a8e:b0:439:bde0:62ea with SMTP id ffacd0b85a97d-439fe1ae91fmr2554188f8f.29.1773271056823;
        Wed, 11 Mar 2026 16:17:36 -0700 (PDT)
Received: from osama ([156.223.222.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm2773963f8f.29.2026.03.11.16.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:17:36 -0700 (PDT)
Date: Thu, 12 Mar 2026 00:17:31 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
Message-ID: <abH4C8RaycAqxySF@osama>
References: <20260307234355.69831-1-osama.abdelkader@gmail.com>
 <guxeojlqqz6cfjdilxnuaeyft4cn4lwdrbplat7xgd5w5hod44@uxqymidomd55>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <guxeojlqqz6cfjdilxnuaeyft4cn4lwdrbplat7xgd5w5hod44@uxqymidomd55>

On Mon, Mar 09, 2026 at 04:12:43PM -0500, Andrew Jones wrote:
> On Sun, Mar 08, 2026 at 12:43:54AM +0100, Osama Abdelkader wrote:
> > When saddr_high != 0 on RV32, the goto out was unconditional, causing
> > valid 64-bit addresses to be rejected. Only goto out when the address
> > is invalid (64-bit host with saddr_high != 0).
> > 
> > Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  arch/riscv/kvm/vcpu_pmu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index 4d8d5e9aa53d..045099ca904b 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -425,9 +425,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
> >  	if (saddr_high != 0) {
> >  		if (IS_ENABLED(CONFIG_32BIT))
> >  			saddr |= ((gpa_t)saddr_high << 32);
> > -		else
> > +		else {
> >  			sbiret = SBI_ERR_INVALID_ADDRESS;
> > -		goto out;
> > +			goto out;
> > +		}
> 
> nit: Could add the {} to the if-arm too in order to keep things balanced.
> Otherwise,
> 
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> Thanks,
> drew
>

Hi Andrew,
I'm going to do that in v2, thanks.
Thanks,
Osama 

> >  	}
> >  
> >  	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
> > -- 
> > 2.43.0
> > 
> > 
> > -- 
> > kvm-riscv mailing list
> > kvm-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kvm-riscv
