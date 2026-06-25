Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230E3BED2D
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367956; cv=none; b=To1odgS2XVAuALhJIeOF3yUQ7Y2EtPBn79xW8pWymq+Ydk2SizJSmlrgfia7i9SRsvHpglzB7l/rwEwD3xHAni4NNx8IUlu6wL5pirOQl1YGQH1pW4Re14V38ZhR9ZAr4lCJTWwPR5kw2oCF2uy9aeolYXND9P1G0Pn8O9qYv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367956; c=relaxed/simple;
	bh=KlHeJ40w4RQjYuBVismbAvB133+6EV4XTpruRWbJIUs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U5S8Fp2f490XCJzIprzA/zNd9YSYx0QLV5eKcJzf6VqEoYqYgEQPC52PsZRZnU1ESAXgiGlQvRo/qWrPSiLc1UO07Xw9RwJBzW82zHEDFWHiwsleWvZM6Cn+SImi73nzKCKTDE3LPw84TwzcyYtjlEImBCTfbhIjtEWhF55R54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 44BF7596952;
	Thu, 25 Jun 2026 08:03:52 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TssivsRiy8G0; Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 28B86596946; Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 25D25596858;
	Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
Date: Thu, 25 Jun 2026 08:03:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Aditya Gupta <adityag@linux.ibm.com>, 
    Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org, 
    qemu-ppc@nongnu.org, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
    =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
    Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
    Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
    devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>, 
    Anushree Mathur <anushree.mathur@linux.ibm.com>, 
    Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, 
    Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
In-Reply-To: <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
Message-ID: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
References: <20260623141933.577981-1-adityag@linux.ibm.com> <20260623141933.577981-4-adityag@linux.ibm.com> <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com> <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-919078764-1782367430=:20522"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-919078764-1782367430=:20522
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
> On 24/06/26 7:14 pm, Aditya Gupta wrote:
>> On 26/06/23 09:24PM, Shivang Upadhyay wrote:
>>> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
>>>> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
>>>> +{
>>>> +    if (chip_type == PNV_CHIP_POWER8) {
>>>> +        return "powernv8";
>>>> +    } else if (chip_type == PNV_CHIP_POWER9) {
>>>> +        return "powernv9";
>>>> +    } else if (chip_type == PNV_CHIP_POWER10) {
>>>> +        return "powernv10";
>>>> +    } else if (chip_type == PNV_CHIP_POWER11) {
>>>> +        return "powernv11";
>>>> +    } else {
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +}
>>> 
>>> How about refactoring to the following?
>>>
>>>      static const char *const machine_types[] = {
>>>          [PNV_CHIP_POWER8]  = "powernv8",
>>>          [PNV_CHIP_POWER9]  = "powernv9",
>>>          [PNV_CHIP_POWER10] = "powernv10",
>>>          [PNV_CHIP_POWER11] = "powernv11",
>>>      };
>>>      return machine_types[x];
>> 
>> Has a subtle difference, that it may not assert/segfault on unknown
>> value for x, I want the test to crash/fail if this is called with an
>> unknown/new processor chip. I believe the if-else/switch is better as it
>> handles (by 'crashing') unknown values too.
>
> We could just do:
>
> if (chip_type >= PNV_CHIP_MAX) {
>    g_assert_not_reached();
> } else {
>    return machine_types[chip_type];
> }

Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?

Regards,
BALATON Zoltan

> That way just adding new array entry would work for future chips.
>
>> 
>> - Aditya G
>> 
>>> 
>>> ~Shivang.
>
>
>
--3866299591-919078764-1782367430=:20522--
