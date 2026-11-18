Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014862;
	b=Y2M69QEgjqGpveW/0XxkzHp+fYzO73ZGn1sKsvzaUTLCYlDRPqN4usQNSyW0/3rOA6h0
	 BhbdX7QeSuYEMOMa4Ft0ZdF1QegGkNuUjet4p2TF2BIF/Ny7hl0AHexfX3GpieDMC6q9k
	 xC2zKFjczczcPStPcwluiWeu1kRdJNuMqjLjkz9QNRa8VLg2ItFT1SSLYYuBoivpPO9Ry
	 MWAcrNU8md+b3uAKJmclUstewu1leqDoP4D6SDwRmniEgsPAyEiy5rDsK1AD+Scjqemd3
	 jsIrWs5TZ1vIAlcFrXOtSJDZ1DMBIF+yCapGoaxLJfqLORhZp0yTLfX4G3ksFEb2HfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014862;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eqAQDHfs/HjyigJ8QZu0i4uhdOip44peu6Dz+/HBUQ4=;
	b=wgsFXLZofRhWY+qkcz/EgrE3SqbhPSHeFQ9GzUj2iuvU5y1JRLhY7JXn7YnNz9Nmb5Ee
	 Lzw3dKqsnn+uNSpX9Gobd1psff0wuBKAqDHweWpsxAe88Rf4wmugBtSHoPjuPLyTGmcnx
	 3V86pnualAfp215EQK2QgltLwsPCFJE667ytJEU3AIrTrus2keZ6qXxuEtTz3hgz6Qyqp
	 LtfCaLohD/QdgcigVhqmf9vTYtLqCzKOnOedcsxXBoYXRbXS1zDf1G7DsmtGhf+ZLIXFF
	 aN9TZyqd392ujC5/4ry8B0/G9H9wdwCtThEuGLE7oXdQkrNaDVKq9vuZnNE23g+JRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lQlMFrIj;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA6606A320
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FA6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lQlMFrIj
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FF91477;
	Wed, 18 Nov 2026 07:14:17 -0800 (PST)
Received: from [10.0.136.98] (M0PRX50XMG.cambridge.arm.com [10.0.136.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DA83F632;
	Wed, 18 Nov 2026 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795014860; bh=uMaMM661VYSYAj+zCHj6huh9RJSq359QkpBA2FPXl/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQlMFrIjL5RHVkFABEZccYe5hwkwSuHtZtHIQHyqUFxGM/OofRmGOAVw4zBAOnT/j
	 qcdyuenJb5pSaTS2XhrmiDq88PS2DEWYlTXQILJt5pVpdZcQ+8DENtFZPtJUFs0hAy
	 A/6nZSjFHjN7L7N2ohuCdJBKD9AWhNF3GXR1gs/E=
Message-ID: <5461a63a-822f-43d8-a571-a109e468237d@arm.com>
Date: Wed, 18 Nov 2026 15:14:18 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvmtool v4 12/23] arm64: Describe timer PPIs for GICv5
To: Vladimir Murzin <vladimir.murzin@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
 <20261102213413.4136118-13-sascha.bischoff@arm.com>
 <6286fa85-fd00-44cb-b03e-87dae6a7107f@arm.com>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <6286fa85-fd00-44cb-b03e-87dae6a7107f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2026 15:23, Vladimir Murzin wrote:
> On 11/2/26 21:34, Sascha Bischoff wrote:
>> GICv5 DT specifiers use absolute PPI numbers due to having separate
>> namespaces for the different interrupt types. Keep the existing
>> GICv2/v3 specifiers by subtracting the legacy PPI base for those
>> irqchips.
>>
>> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
>> ---
>>   arm64/timer.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arm64/timer.c b/arm64/timer.c
>> index 2ac6144f..01b9875c 100644
>> --- a/arm64/timer.c
>> +++ b/arm64/timer.c
>> @@ -9,16 +9,18 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>>   {
>>   	const char compatible[] = "arm,armv8-timer\0arm,armv7-timer";
>>   	u32 cpu_mask = gic__get_fdt_irq_cpumask(kvm);
>> -	int irqs[5] = {13, 14, 11, 10, 12};
>> +	const int irqs[5] = { 29, 30, 27, 26, 28 };
>>   	int nr = ARRAY_SIZE(irqs);
>>   	u32 irq_prop[nr * 3];
>> +	u32 type = gic__get_ppi_fdt_type();
>> +	int ppi_base = gic__get_ppi_base();
>>   
>>   	if (!kvm->cfg.arch.nested_virt)
>>   		nr--;
>>   
>>   	for (int i = 0; i < nr; i++) {
>> -		irq_prop[i * 3 + 0] = cpu_to_fdt32(GIC_FDT_IRQ_TYPE_PPI);
>> -		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i]);
>> +		irq_prop[i * 3 + 0] = cpu_to_fdt32(type);
>> +		irq_prop[i * 3 + 1] = cpu_to_fdt32(irqs[i] - ppi_base);
>>   		irq_prop[i * 3 + 2] = cpu_to_fdt32(cpu_mask | IRQ_TYPE_LEVEL_LOW);
>>   	}
>>   
>> @@ -30,4 +32,3 @@ void timer__generate_fdt_nodes(void *fdt, struct kvm *kvm)
>>   		_FDT(fdt_property_cell(fdt, "clock-frequency", kvm->cfg.arch.force_cntfrq));
>>   	_FDT(fdt_end_node(fdt));
>>   }
>> -
> 
> Unintentional change?

Argh, yes! Sorry, that these keep sneaking in. Fixed.

> 
>> -- 2.34.1
>>
> 
> 
> Otherwise,
> 
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

