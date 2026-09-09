Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE251120E
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951176; cv=none; b=YBFdFOVr1dng+R/vhr3/eOXYGS2MuvK3Q67HNtNNbR6UZbQGQ+5p7ytSDXuIc7CH8+53+LJdlKeGq8UlZH1pbrhBUxrihjrZh6WS8n4cCzvmEtTmYXbimxuJmF+80ZhNQXgiMNVqjKcUhWb2WLxk7RfmLzi3fKzQN6v6yiDM42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951176; c=relaxed/simple;
	bh=C7u8iRDxIF8RMwZk7KKyYWmXBhq4KkK0dHqbcUGkab4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nceTEI85XpD8j1jh3wpFIEwIYAUN2yPNr74tb/7UAaQN7GMTaKhA0FQ59b6RK5V6wG8NbJQfEa3mt9caxD/3j0KiNoM7cunK5SeUS2CQyiNedWdoRyDcE2lZOOTdhjIPhGqF+tuAe8DW2orhczcjbQiZ4SwfrDxipREn/oMkC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzsy1fuS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJsdXUwC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzsy1fuS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJsdXUwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788951170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlII6PmLS6Fy2IEhFtMVBBXGY0oZneRlW8U4Qxok/SY=;
	b=bzsy1fuS9AHd2lbQ6V3T49p5BrxdapyPInxyEU8e98D9fmxEN0aye874hFnn8JSD/iUYxP
	X9PkNsJR/2G2hFAVPUXcK9ixaPmcQ3ykOFZYTLwYtLU+CJ8NiiM76WV1fdUZbeGurNCN1M
	sSg6o6d9iA0CyHSKuJoPWyUhzbzX4AE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-BYEo8HMoOFq3S_Ppu8zqOw-1; Wed, 09 Sep 2026 06:52:48 -0400
X-MC-Unique: BYEo8HMoOFq3S_Ppu8zqOw-1
X-Mimecast-MFC-AGG-ID: BYEo8HMoOFq3S_Ppu8zqOw_1788951168
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so7196021a91.3
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788951168; x=1789555968; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlII6PmLS6Fy2IEhFtMVBBXGY0oZneRlW8U4Qxok/SY=;
        b=YJsdXUwC3+82SB2u74PQ73BBaKhgoGexklBabaFG9DuSJLQPFYH1O9o1+K2S3IfrsR
         gh3fchvOy635K0mmtF4gZpMoL0MGOtNPtYWjMEBlq3lakKsbbYgTD1GEANcMwuXi1e2R
         gq/nC9HnDALRGNKM10RI+x5ts9yagBrjLbW9arZfvqcCSKo7lWT4Hmt4biocqeqCeFYe
         sbmfiV3BPZx8ANyQ8giVdbSQgR3arIuK4HSSpqBktt6hcoWTlVisdlc3Q+fwtQ83EZYw
         R/fCE1wEGC7KOFjShKcVrpb/lKcdwMTX2eFa58go4z++1sFFOtoeEm6PVNPyJbtzygyr
         Gd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951168; x=1789555968;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlII6PmLS6Fy2IEhFtMVBBXGY0oZneRlW8U4Qxok/SY=;
        b=i6wjGvUyHACAZfq3SpK6r7Ruwa4QIB2NvrQlUY2JLrHzNyIanCKgS7VNNYxNhCEjqM
         xOKN6PgYGwmWcsv2qrNYd7kds3DR4qbzHNxC8mcOzIpg1XPbiQzQ/A75H5ZvZZyPX7AA
         KauYbq56MSG/MLRk0uZV1eJyMIbYmI4OWSgYWietwlqzQfxZHVNIyD38s81ZkLB4yjgQ
         Ar5ttqBvdFMewSkgunczaAXGTLqJZul0R0AfpW1NaRKmSxS5AriJOAri81gVy1gb4EVS
         qN1CH5UsAaIew39vLsnC9W69EG9LZRrvBv1G0ynYhbD5DiYyKBvgRPpnKyQBhln+5jaJ
         /lng==
X-Gm-Message-State: AFuF++k1osRIG3qnAjInl/MlC9MQA5NJdrtEHZNXtBstWSdGL9K5GCYH
	kUROkYCVCAsBEJAsuDEa54afPkVj5L8nUFwoxCyAPULgQX6KXNnUzQj7xIZbc5SQzCCGIelrSwE
	Y+gQtL/heeDhzcmlIugb92icXQetRYsSdK4wUhkkIkEpFXzJ+rkp+cg==
X-Gm-Gg: AYBFou0gZvkRW+XDSDkCUI0V3V7N/6XiZv9ICYHdzsCFHB/zFAJcJj62IAkNG/v6l6s
	aNg00BTkwQx/JP1hzz+22+pm7ttg3k9aE9fcKYYihUaJ7dwcAljMn2sUqCsRxR2uvVbUeQIifTY
	HDR3WFtrM9W18QgobOi+REn2XQwwb74lDSAbNk1DDqHlJDFx/Z3ZkxgBBnhra61xBeQWqR7lxwl
	HK2F+p/mX5FhPF4VduVF0DMpGpTnWkYRfklnbZkFBnysB1PwKyauafZehz0ORp2a81DxgPzbiFL
	vdKxfpFbF9KxpNTp0Gdv395IIJ/VkxPXWxSt5dBt4VAjxRCMnk6aucvAIAWDoC+Y/6rLGxXDmAL
	hyj2qEDTHthZxRvGMuH88CIXstnNPenRGjDoIo8561g==
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-39b26101c20mr51714288a91.9.1788951167274;
        Wed, 09 Sep 2026 03:52:47 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-39b26101c20mr51714221a91.9.1788951166708;
        Wed, 09 Sep 2026 03:52:46 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fe843sm31417683a91.10.2026.09.09.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:52:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ARHmqz6kmyRmg021RcSq0ymY"
Message-ID: <9086ca6a-5dce-493f-ac76-487dedc60758@redhat.com>
Date: Wed, 9 Sep 2026 20:52:33 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/7] firmware: arm_rmm: Add RMM v2.0 base RMI support
To: Kohei Enju <enju.kohei@fujitsu.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
 will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
 aneesh.kumar@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
 tabba@google.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev,
 gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com,
 alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com,
 lpieralisi@kernel.org
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <ap-C6NLnxuWWTMzi@FCCLS0092175.localdomain>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ap-C6NLnxuWWTMzi@FCCLS0092175.localdomain>

This is a multi-part message in MIME format.
--------------ARHmqz6kmyRmg021RcSq0ymY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kohei,

On 9/8/26 2:09 PM, Kohei Enju wrote:

[...]

>>
>> [1] RMM spec : https://support.arm.com/documentation/den0137/2-0bet3/
>> [2] This series: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/fw_rmm/v17
>> [3] KVM CCA v17 integration branch: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/kvm-integration/v17
>> [4] Gmem inplace conversion https://github.com/googleprodkernel/linux-cc/tree/guest_memfd-inplace-conversion-v12
>> [5] TF-RMM https://git.trustedfirmware.org/TF-RMM/tf-rmm.git main (commit: 134266ae)
> 
> I understand that QEMU-virt is not intended to model a realistic
> production platform and that QEMU-SBSA is generally preferred. However,
> I sometimes use QEMU-virt to test functionality quickly because it runs
> slightly faster than QEMU-SBSA.
> 
> I tested this series with QEMU-virt and found that RMM initialization
> failed during boot:
> 
>    [...]
>    INFO:    BL31: Initializing RMM
>    INFO:    RMM init start.
>    ERROR:   RMM init failed: -8
>    WARNING: BL31: RMM initialization failed
> 
I also ran into same issue and attached TF-A patch leads to a successful
RMM initialization, please have a try to see if it can resolve your issue.


Thanks,
Gavin
--------------ARHmqz6kmyRmg021RcSq0ymY
Content-Type: text/x-patch; charset=UTF-8; name="tf-a.patch"
Content-Disposition: attachment; filename="tf-a.patch"
Content-Transfer-Encoding: base64

RnJvbSBjMjJkZGM0MzY4NjUwNTUwODQ1Zjg2MmZjMDdjYjM1Yjk5OGZiYjIzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPgpE
YXRlOiBXZWQsIDkgU2VwIDIwMjYgMTk6NTg6MzcgKzEwMDAKU3ViamVjdDogW1BBVENIXSBw
bGF0L3FlbXU6IGFkZCBwbGF0X3JtbWRfcmVzZXJ2ZV9tZW1vcnkoKSBmb3IgVklSVCBwbGF0
Zm9ybQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2lnbmVkLW9mZi1i
eTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4KLS0tCiBwbGF0L3FlbXUvcWVtdS9p
bmNsdWRlL3BsYXRmb3JtX2RlZi5oICB8ICAzICsrKwogcGxhdC9xZW11L3FlbXUvcGxhdF9y
bW1fbWVtX2NhcnZlb3V0LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKwogcGxh
dC9xZW11L3FlbXUvcGxhdGZvcm0ubWsgICAgICAgICAgICAgfCAgNCArKysrCiAzIGZpbGVz
IGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBwbGF0L3Fl
bXUvcWVtdS9wbGF0X3JtbV9tZW1fY2FydmVvdXQuYwoKZGlmZiAtLWdpdCBhL3BsYXQvcWVt
dS9xZW11L2luY2x1ZGUvcGxhdGZvcm1fZGVmLmggYi9wbGF0L3FlbXUvcWVtdS9pbmNsdWRl
L3BsYXRmb3JtX2RlZi5oCmluZGV4IDA2MDE4ZTdiMi4uYzNlZDk4NmNmIDEwMDY0NAotLS0g
YS9wbGF0L3FlbXUvcWVtdS9pbmNsdWRlL3BsYXRmb3JtX2RlZi5oCisrKyBiL3BsYXQvcWVt
dS9xZW11L2luY2x1ZGUvcGxhdGZvcm1fZGVmLmgKQEAgLTM2OCw2ICszNjgsOSBAQCBDQVNT
RVJUKChQTEFUX1FFTVVfTDBfR1BUX0JBU0UgJiAoUExBVF9RRU1VX0wwX0dQVF9TSVpFIC0g
MSkpID09IDAsCiAjZGVmaW5lIFJNTV9TSEFSRURfQkFTRQkJCShSTU1fTElNSVQpCiAjZGVm
aW5lIFJNTV9TSEFSRURfU0laRQkJCVBMQVRfUUVNVV9STU1fU0hBUkVEX1NJWkUKIAorI2Rl
ZmluZSBQTEFUX0FSTV9STU1fUEFZTE9BRF9TSVpFCVVMKDB4NjAwMDAwKSAgICAvKiAyICog
M01CICovCisjZGVmaW5lIFJNTV9QQVlMT0FEX0xJTUlUCQkoUk1NX0JBU0UgKyBQTEFUX0FS
TV9STU1fUEFZTE9BRF9TSVpFKQorCiAvKgogICogV2UgYWRkIHRoZSBSTU1fU0hBUkVEIHNp
emUgdG8gUk1NIG1hcHBpbmcgdG8gbWFwIHRoZSByZWdpb24gYXMgYSBibG9jay4KICAqIEVs
c2Ugd2UgZW5kIHVwIHJlcXVpcmluZyBtb3JlIHBhZ2V0YWJsZXMgaW4gQkwyIGZvciBST01M
SUIgYnVpbGQuCmRpZmYgLS1naXQgYS9wbGF0L3FlbXUvcWVtdS9wbGF0X3JtbV9tZW1fY2Fy
dmVvdXQuYyBiL3BsYXQvcWVtdS9xZW11L3BsYXRfcm1tX21lbV9jYXJ2ZW91dC5jCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uYzY4Y2EyNDNkCi0tLSAvZGV2L251
bGwKKysrIGIvcGxhdC9xZW11L3FlbXUvcGxhdF9ybW1fbWVtX2NhcnZlb3V0LmMKQEAgLTAs
MCArMSwyOCBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNiwgQXJtIExpbWl0ZWQgYW5k
IENvbnRyaWJ1dG9ycy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogQlNELTMtQ2xhdXNlCisgKi8KKworI2luY2x1ZGUgPGxpYi9zcGlu
bG9jay5oPgorI2luY2x1ZGUgPHBsYXQvY29tbW9uL3BsYXRmb3JtLmg+CisKK3N0YXRpYyBz
cGlubG9ja190IG1lbV9yZXNlcnZlX2xvY2s7CitzdGF0aWMgdWludHB0cl90IHRvcF9tZW0g
PSBSTU1fTElNSVQ7CisKK3VpbnRwdHJfdCBwbGF0X3JtbWRfcmVzZXJ2ZV9tZW1vcnkoc2l6
ZV90IHNpemUsIHVuc2lnbmVkIGxvbmcgYWxpZ25tZW50KQoreworCXVpbnQ2NF90IGFsaWdu
X21hc2sgPSBhbGlnbm1lbnQgLSAxOworCXVpbnRwdHJfdCBhZGRyOworCisJc3Bpbl9sb2Nr
KCZtZW1fcmVzZXJ2ZV9sb2NrKTsKKwlhZGRyID0gKHRvcF9tZW0gLSBzaXplKSAmIH5hbGln
bl9tYXNrOworCWlmIChhZGRyID49IFJNTV9QQVlMT0FEX0xJTUlUKSB7CisJCXRvcF9tZW0g
PSBhZGRyOworCX0gZWxzZSB7CisJCWFkZHIgPSAwOworCX0KKwlzcGluX3VubG9jaygmbWVt
X3Jlc2VydmVfbG9jayk7CisKKwlyZXR1cm4gYWRkcjsKK30KZGlmZiAtLWdpdCBhL3BsYXQv
cWVtdS9xZW11L3BsYXRmb3JtLm1rIGIvcGxhdC9xZW11L3FlbXUvcGxhdGZvcm0ubWsKaW5k
ZXggMmUxMmY2YmNhLi42NTVjYzY4M2EgMTAwNjQ0Ci0tLSBhL3BsYXQvcWVtdS9xZW11L3Bs
YXRmb3JtLm1rCisrKyBiL3BsYXQvcWVtdS9xZW11L3BsYXRmb3JtLm1rCkBAIC0xNzUsNiAr
MTc1LDEwIEBAIEJMMzFfU09VUkNFUwkJKz0JcGxhdC9jb21tb24vcGxhdF9zcG1kX21hbmlm
ZXN0LmMJXAogCQkJCSR7RkRUX1dSQVBQRVJTX1NPVVJDRVN9CiBlbmRpZgogCitpZmVxICgk
e0VOQUJMRV9STU19LDEpCitCTDMxX1NPVVJDRVMJCSs9CSR7UExBVF9RRU1VX1BBVEh9L3Bs
YXRfcm1tX21lbV9jYXJ2ZW91dC5jCitlbmRpZgorCiBpZm5lcSAoJHtFTkFCTEVfRkVBVF9S
TkdfVFJBUH0sMCkKIEJMMzFfU09VUkNFUwkJKz0JcGxhdC9xZW11L3FlbXUvcWVtdV9zeW5j
X3RyYXBzLmMKIGVuZGlmCi0tIAoyLjU1LjAKCg==

--------------ARHmqz6kmyRmg021RcSq0ymY--

