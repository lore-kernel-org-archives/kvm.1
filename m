Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645008;
	b=YMIS0VTWun37DEu78t5BOBfS/LvYfuajn3k4LkzZ2UHsNO+D63H+J/DH/gGhAba6DWr+
	 oxyW90GLF0+0C815oh5fHmnisxDvOzMoHTc076uAdPCLIBwBWQ626VZJUI9Dns+MFBOkW
	 827lLCXGTfsF/1Tep9vzx5tHUjTL97cP8tfAHPfKzYcEfyFQ9EdZXzVR74JZdFxrInF22
	 /myjUMe6UeSvQ1Tm6QPKy7YvRjJDEZuZWvO6sk3ty5eRJUmTnazBanxHMPSD8OBkRnZwg
	 dYYosp47gCYcbePm5/VEQeOjGqfR69L/qFb0OLA5sV1Kgz5iWhlgNgzTZla1zpJwjtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645008;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d8M95H69R0GVpRra/FsjqWhUbWLcwcGJtzbc38SKSco=;
	b=NV0HIGrT91aDTmgHtMBWL7PY77ezeSkbMn64OBcXh++UgKZxAfFq+8ZFriTz6/G9Xtpo
	 /LQRYm/PhWYogocBDn9Lrhxx+NeFdrm0a9QgQjn3o2kjrN2I8elUMTzNfiObfEoAW+EXJ
	 QbPNa6pdbT8cpRQIP1w3SnWWxBzJIdhuguPuBdk816XnMcK4WrQGE7PiNsXLzmFmEgbv/
	 T5W7yMa96Ade4hJbhlamitQUI/udhoGqcWy5d1lcCPzylHrkloaQfECyB+6wV65BAJrTI
	 bwHzfEQf8A5lC2A3FRgrP4+yfHW4dGLNQXWLsIg2ZqzbAPoQWiIyAS5ogVxXYTOBgwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Rt49Ezrz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708BF606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Rt49Ezrz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A9A1C14;
	Mon,  2 Nov 2026 10:43:23 -0800 (PST)
Received: from [10.57.89.36] (unknown [10.57.89.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E39C3F673;
	Mon,  2 Nov 2026 10:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793645006; bh=e/apkQ+PUTPkWx2JCcH7zwo0mzEjRVDTMtVntiX6q2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rt49Ezrzyu8ojaEZum7Pvn5HC/hulevEkgupKNQAcGqvZKdKkGcS8ZOFd8Ro3Dw2M
	 Gt2x/7FiaFLK8oro7pIl6oq7iB+X+WNpZAlxZRv0xe9ETdkaUkKuL4Fqsnx04Gbi0z
	 +66d8Jz42ioQW/tYZrNYwG2ofQFVj92braPUmKIs=
Message-ID: <05133376-f88a-49d4-bcc8-4b406c18aa7d@arm.com>
Date: Mon, 2 Nov 2026 18:43:24 +0000
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
Subject: Re: [PATCH 14/16] KVM: selftests: Add VGICv5 ITS attribute tests
To: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261016155741.979985-1-sascha.bischoff@arm.com>
 <20261016155741.979985-15-sascha.bischoff@arm.com>
 <sashiko-outbox-174624@kernel.org>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <sashiko-outbox-174624@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 17:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] kvm: selftests: tautological test for ITS DT_CFGR/DT_BASER updates
> - [Low] kvm: selftests: missing idle status register checks for ITS
> --
> 
> commit c7601fac392a61f968d6064e81cd764b666cb504
> Author: Sascha Bischoff <sascha.bischoff@arm.com>
> 
> KVM: selftests: Add VGICv5 ITS attribute tests
> 
> This commit adds coverage for the VGICv5 ITS device address and ITS_REGS
> attribute groups. Userspace needs to be able to discover and save the virtual
> ITS register state, while KVM must reject invalid address placement and
> malformed register accesses.
> 
>> diff --git a/tools/testing/selftests/kvm/arm64/vgic_v5.c b/tools/testing/selftests/kvm/arm64/vgic_v5.c
>> index d5df742b23001..b7fb002a64f6c 100644
>> --- a/tools/testing/selftests/kvm/arm64/vgic_v5.c
>> +++ b/tools/testing/selftests/kvm/arm64/vgic_v5.c
> [ ... ]
>> @@ -1287,6 +1339,177 @@ static void test_vgic_v5_irs_regs_attrs(void)
>>   	vm_gic_destroy(&v);
>>   }
>>   
>> +static void test_vgic_v5_its_attrs(void)
>> +{
> [ ... ]
>> +	/* Check MMIO by checking if present, reading, then writing back */
>> +	for (i = 0; i < ARRAY_SIZE(gic_v5_its_regs); i++) {
>> +		attr = gic_v5_its_regs[i].attr;
>> +		ret = __kvm_has_device_attr(v.its_fd,
>> +					    KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +					    attr);
> 
> [Severity: Low]
> The commit message mentions exercising "idle status register values", but this
> loop only reads and writes back the registers without checking their values.
> Should there be an explicit assertion that the status registers (like STATUSR,
> SYNC_STATUSR, GEN_EVENT_STATUSR) actually read as idle? The corresponding
> test_vgic_v5_irs_regs_attrs() test includes these checks for the IRS.

The virtual ITS always reports these registers as idle and has no 
in-progress state for this test to observe. Some of the idle bits also 
have architecturally UNKNOWN reset values. An assertion here would only 
check KVM's chosen constant, so I've left the test unchanged.

All of that said, the commit message definitely claimed things that it 
was not doing. I've dropped that from the commit message. We don't check 
the idle values, and never should bother to check those as they tell us 
nothing meaningful.

> 
> [ ... ]
>> +	/* Make sure we can restore the vITS's enable state */
>> +	val = GICV5_ITS_CR0_ITSEN;
>> +	ret = __kvm_device_attr_set(v.its_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +				    GICV5_ITS_CR0, &val);
>> +	TEST_ASSERT(!ret, "GICv5 ITS_REGS failed to enable ITS");
>> +
>> +	/* And DT CFGR/BASER */
>> +	val = 0;
>> +	ret = __kvm_device_attr_set(v.its_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +				    GICV5_ITS_DT_CFGR, &val);
>> +	TEST_ASSERT(!ret, "GICv5 ITS_REGS rejected enabled DT_CFGR update");
>> +	ret = __kvm_device_attr_get(v.its_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>> +				    GICV5_ITS_DT_CFGR, &val);
>> +	TEST_ASSERT(!ret && !val, "GICv5 ITS_REGS DT_CFGR restore mismatch");
> 
> [Severity: Low]
> Is this test effectively verifying that the updates to GICV5_ITS_DT_CFGR work
> while the ITS is enabled?
> 
> Because val is set to 0 (the default/reset value of the register) before the
> write, if the kernel incorrectly discards the write while ITSEN=1, the
> register will remain 0 and the read-back will return 0, allowing the test to
> pass spuriously. Writing a non-zero valid value would avoid this tautology.
> 
> Also, the test writes GICV5_ITS_CR0_ITSEN to CR0 but never reads it back.
> Could the test be trying to update the configuration registers on a disabled
> ITS if the enable bit didn't actually stick?

Ah, yes. Writing zero to DT_CFGR could pass even if the write was 
ignored so that wasn't the most helpful. Also, the test did not confirm 
that the ITSEN value stuck. I've added CR0.ITSEN read-back to check that 
the set value persists, and a nonzero, valid DT_CFGR DeviceID limit with 
read-back. Hopefully, that addresses the issues raised here.

> 
>> diff --git a/tools/testing/selftests/kvm/include/arm64/gic_v5.h b/tools/testing/selftests/kvm/include/arm64/gic_v5.h
>> index 2d455515563e0..22ab78626af5a 100644
>> --- a/tools/testing/selftests/kvm/include/arm64/gic_v5.h
>> +++ b/tools/testing/selftests/kvm/include/arm64/gic_v5.h
> [ ... ]
>> +#define GICV5_ITS_CR0_IDLE		BIT(1)
> 
> [Severity: Low]
> Is this macro correct for the ITS? It defines an IDLE bit for CR0, but it
> appears to be unused in the test. Looking at the GICv5 architecture, it seems
> only the IRS has an IDLE bit in CR0, not the ITS.
> 

ITS_CR0 definitely has an IDLE field at BIT(1) so that definition is 
correct. That said, I've dropped it given that we don't use it.

Thanks,
Sascha
