Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806832FA2E
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826705; cv=none; b=Akt07DflTlk48T5z/JDF9o0cQJyuJOyP3ZOlMCYfNreoigmCVc1wtE1L8dGFDl1h3s+uWbeYxhz079yprwlRY71mgo9FGE3bPTy8JlDy0ingiK2KeqNxVP3xgGGkwWbwyv5auhnKkM3Gt4um7eB19q+RvUWe+pTJrbumJbGRwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826705; c=relaxed/simple;
	bh=LSdlUfbS6mSNUj5xcGjcMT4ohXXE09tTSwdtALp716U=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gXwX5nOmp04JR1xMxAmUC4Kw0RhrWNH5+CugmJ/b+t7WXNgfPPv7t3SJQH8Fklf9AfbM5y8Oqhyq/OCiZeXr57l6Z/8zOvy8b4py1ZOi43WcF8481r+c1g+T8lMM848odXC6CIvK8R2Plw2x6khLSTRj0mBlMmPCrfVE6h8Y3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxvfb24W; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxvfb24W"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48687df43c4so3216513b6e.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781826703; x=1782431503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wl+XkAlSIV7reClA+yYwrnI1d2Koghf+XpHoLtIn5rc=;
        b=qxvfb24WS5Sb0b25mfEvL6PsogLrN2ihLjuUT//Ua+MTEgm4KNTY3YhpVMWtv28/6C
         HFmpoDpRssfae0REQk0cuLTGm+OIUPEmE4nlt9CdrGnHS94HheeBe7WuuNEF43kKMOpT
         kPYDjc+UGkO9yJxn2FBmBrzYixLp3pE8qlLQ4wmbFkr1LM/iT1HTOB7HP+viLfEeCmkM
         xY6bCNVn6S04mz5Rwx4xz1DX5YBQiMD+SNnryNek2s+9JMWshmNY58xKlXnhUxSOX6sc
         0XYq3V6fpHwWyjcD0H4CRB2bORN4gtoRnKg90PfzZrQAvvRfdb5fD5f8PKkoYHERkFwm
         CvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781826703; x=1782431503;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl+XkAlSIV7reClA+yYwrnI1d2Koghf+XpHoLtIn5rc=;
        b=TDFMYdzvauSSz5UgrJEPkSl6zzcWj8ir3VbZH1FIVUx2x+GMJIwnHwFRnunYW+Fdw1
         GfIFgLnoFC0R23ofYnG16ShcNzfgu0vhfwCFCeADB254VP05vR+IEYiWdGJAWkW7vAcx
         OIZ5QA7zAv6l+uOLA7djLBUMEpNIBAsOdL4V/qS0t/nuxWoi8MYGsKQHVPnuZnZhPiXA
         fQhxnqW+Bi7fCdZURZLlZzH66zmfknC9GUfBrtU/s9nIEa/VOpRuA52VcXvQwn4mJ1Xq
         xBfPY2K168xDpJckBTUylyjd4ow2LjU5lTO5UTSvMMAiBjavYiFlS0fslEa/4VZJOMru
         yQzw==
X-Forwarded-Encrypted: i=1; AFNElJ/dOW4HbF+CIktBGqNqjR/iLlGJhcaPFWBjIcfxrnPafIbBc4ffnl8yVWAHx8AWQseRuc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUAasEKXVPriRmsB9MBVL4h0e32VG8zhx/PIv2l216CvUguX3
	TcXnKnGOrOyW7pvNnY44Env7vZQxDgcPzE6BYzpkD/hQMvhV2Br3idlBwcKNzLzg/V6a5PAM1az
	hJrVsKpfp4vmR4fXLcLCyNyYd5A==
X-Received: from jahk15.prod.google.com ([2002:a05:6638:8bcf:b0:5e4:88f2:4eae])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5296:b0:486:45c7:34bf with SMTP id 5614622812f47-4896aa680f6mr1489246b6e.16.1781826703239;
 Thu, 18 Jun 2026 16:51:43 -0700 (PDT)
Date: Thu, 18 Jun 2026 23:51:42 +0000
In-Reply-To: <ajQZ6aKPnybVueJC@raptor> (message from Alexandru Elisei on Thu,
 18 Jun 2026 17:16:41 +0100)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpl1ncsq9.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [kvm-unit-tests PATCH] arm: io: Set is_pl011_uart flag in ACPI initialization
From: Colton Lewis <coltonlewis@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: andrew.jones@linux.dev, eric.auger@redhat.com, maz@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi,

> On Wed, May 13, 2026 at 09:16:24PM +0000, Colton Lewis wrote:
>> When booting via ACPI on ARM64, the SPCR table is parsed to initialize
>> the console UART. However, the code was neglecting to set the
>> is_pl011_uart flag. This caused __getchar() to fall back to treating
>> the UART as a 16550A device, which fails on systems with a PL011.

>> Tests that wait for serial input (like its-migration) would hang
>> indefinitely because __getchar() would always return -1.

>> Update uart0_init_acpi() to inspect the SPCR interface_type and set
>> is_pl011_uart accordingly. Also define macros for the first four SPCR
>> interface types in lib/acpi.h based on the Microsoft specification.

>> Link:  
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table#table-3-debug-port-types-and-subtypes
>> Assisted-by: Gemini:gemini-3.1-pro
>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   lib/acpi.h   | 6 ++++++
>>   lib/arm/io.c | 3 +++
>>   2 files changed, 9 insertions(+)

>> diff --git a/lib/acpi.h b/lib/acpi.h
>> index 66e3062d..29b3edd5 100644
>> --- a/lib/acpi.h
>> +++ b/lib/acpi.h
>> @@ -251,6 +251,12 @@ enum acpi_madt_type {
>>   /* MADT Local APIC flags */
>>   #define ACPI_MADT_ENABLED		(1)	/* 00: Processor is usable if set */

>> +/* Values for interface_type field in struct spcr_descriptor */
>> +#define ACPI_SPCR_INTERFACE_TYPE_16550		0x0000
>> +#define ACPI_SPCR_INTERFACE_TYPE_16450		0x0001
>> +#define ACPI_SPCR_INTERFACE_TYPE_16550_32BIT	0x0002
>> +#define ACPI_SPCR_INTERFACE_TYPE_ARM_PL011	0x0003

> We could also use the defines from the Linux source tree, from
> include/acpi/actbl1.h (look below struct acpi_dbg2_device).

Sounds good. I did not know those were there.

> I got a bit confused about the value 2 above, because in the Debug Port
> Table 2 (DBG2) from the link, that value is for a 'MAX311xE SPI UART'. Not
> saying that it's not the same thing as a 32 bit 16550 uart (or that it
> is!), just saying that the names don't appear to be matching.

I'll make that consistent.

>> +
>>   struct spcr_descriptor {
>>   	ACPI_TABLE_HEADER_DEF	/* ACPI common table header */
>>   	u8 interface_type;	/* 0=full 16550, 1=subset of 16550 */
>> diff --git a/lib/arm/io.c b/lib/arm/io.c
>> index 836fa854..55102bd7 100644
>> --- a/lib/arm/io.c
>> +++ b/lib/arm/io.c
>> @@ -81,6 +81,9 @@ static void uart0_init_acpi(void)

>>   	assert_msg(spcr, "Unable to find ACPI SPCR");
>>   	uart0_base = ioremap(spcr->serial_port.address,  
>> spcr->serial_port.bit_width);
>> +
>> +	if (spcr->interface_type == ACPI_SPCR_INTERFACE_TYPE_ARM_PL011)
>> +		is_pl011_uart = true;

> The patch makes sense to me. With or without the Linux define names:

> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thank you Alex. I'll reroll the patch with your suggestions.


> Thanks,
> Alex
