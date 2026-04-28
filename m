Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7044DB6D;
	Tue, 28 Apr 2026 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399132; cv=fail; b=MIajf4f95VA7sN22ahNetes2oCXF2famo06JCSUezv2mFq7HIz1iTHpS5mWzhzKMzJt4Qk2mdsX7h2XocZwbADeMix7E1t6wnOIgoUFesYBuAWPEuDyl3NrMtv0D0PQrE9ZiCNN0XYh5NG74OlaLFXrN02sf21lHBiRZuaDxT24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399132; c=relaxed/simple;
	bh=phmmjinFyYVDz3KwcO/i5NLFoO9uTsYYlcrVZhbDBcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2NJBNnl5HnCyTN63KIH06bsyt/wE+BenYhO+iBoi9vYTfMYviKJzYfDMEvdWXrNjW7IvcY2FdFTruIWNhXKiTbsCLAyTAoPvSSUvW/Nmby0Rtctr+ybI23mBdzCgZ4JTqgmwyOj9yFWpJCF49doe+yRqeImDr9PV4i8tjYioJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IuQE+jcf; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IuQE+jcf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHUG58HL1DfcawQWKAHopCK6T1ZOs7kFN7zmY+HMoTqmqSe5BzWMvQhbYBDIVl5nAAIWcmSjFPIPeAHAg3V7pXGWR/Rhm3tjgrTKBOKG3lmcRboAFQz017mqgu7qlEGfAIkwXyRwOu7qmb5uf4SyDPlVLoXFfStcBAyWgjcHhqxJNn4fLnVpSdKbwonMz8p2rEH/p99avkh71VvYuecND3r7TNV0E9iCwva/up7dmE2WsxOlehHcji0H8FlYCQ13qLf9OcfXzeAs6l9PPXFl/5qQjYkAcpt+C7BxWV1fqLGAJOoWE1A9Y3zdm2CvREeLbmebzi7eRmsrR/3BKQJ63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/FpJzT/SCko0mGoHyPWsH02QCALShcEKdMRXCx6IbM=;
 b=Tv3ZFkFrq04XCiJLaXkEqY6yA73JG8WFRiJ3vKAqK4RriE6RCFFdyot13eIDSWp6DiAo7ntUTZCYXLRPw8UK8Q//62sVuvdclcbpKhBftqADdle0BjzZs63vagUGmwEfwltjZZm4qNrvxDcCCkwBK3h+8DIyriihcBuhFmOs0OV5v+xQC+zbFs1XBlqyu2/MixiLEAatqTFvtyURxTXFsHG9grjayOXQO7pZDv2KlNidjyWhxp4QDudYOBmVXlEO3AcgQZjd4z9+aZLibCkE4FUtLgkuxFU2Zxs5QwW1qarPIh3mNuSkii+rDpdeHB4xoTwHeD1dEAwWgv9ZeHYqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/FpJzT/SCko0mGoHyPWsH02QCALShcEKdMRXCx6IbM=;
 b=IuQE+jcfIFM2ekCdqvUtmGCS/0EINIa7Nz6zuW3wit7Vbgq3UxdhXnKfAIQ6v6xSh9sO7tiFC+HO+57s2qjvEB/4a0uFZkQ4UBh5SghrvLc9v6F7SBI26+naOrk3nNA2hXqNWyK6ldfkaubuZ63k1Os2/5fZs8fvQuQfLiNMs9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 17:58:47 +0000
Received: from PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923]) by PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 17:58:47 +0000
Message-ID: <c90bd541-a54d-478c-b618-226696679f4b@amd.com>
Date: Tue, 28 Apr 2026 10:58:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] KVM: SVM: Inject #HV when Restricted Injection is
 active
To: Joerg Rodel <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <954d023cc355d1ab867c7f983c8fa830b29ee659.1777048608.git.huibo.wang@amd.com>
 <7sewxapo7kapbfxw463crzltkojmylmlldtqxdzhaf4bnhecz5@vzn2nemcgqak>
Content-Language: en-US
From: Melody Wang <huibo.wang@amd.com>
In-Reply-To: <7sewxapo7kapbfxw463crzltkojmylmlldtqxdzhaf4bnhecz5@vzn2nemcgqak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To PH7PR12MB8106.namprd12.prod.outlook.com
 (2603:10b6:510:2ba::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8106:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: b30f719f-3553-4d5e-dcf8-08dea54fcb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b0XbsIXkh509617IIVlZ2Z5QnoTAX3SIUojGj99QC7URN0K+aH/iTs7vFcm0fWwhyLW3tkvdVKocKfn3M5JCsqVVusPJFFQdTipLwroDe1M87EZhDkyc81yt06Y38KWa06Ws1B9sx0kPgNam+w0d11zxOBFV8Qq/HaM4WWTxncmhOTp4SiVPsW6vxdZn67YCiYW0k6nxyby2OMqNIsgnE27bNqPxJVRZFEOk0JeqA1l4YbejMZBo2P0d0mbHQ5+D/DDVr/JqugFHA14vveT2o2+glUpRQGI8hZ9IlYxjgJYn/Kwh15yCV3a+m2PqLmnnO2msTO8k0ZFopXDK8ROkwBZ3DBnTueXcXThdF/uh66ZmK7AWdosAlTjsD+1pqukYk5cKbWoMQKVkND0bqMDhJUrGAva5VwaWbttrHq4xArIYC6hc0xtsJ9XqIKpDcqgVKnvgbIon2dQra3ZQW8c2lbNA+vf5jCTpIVg/RIs0M5LeV9NPxat2IXIVAPXhFUAqJ6uG+wX9YZt5P4Hmiy2VwBLglF084c1otAXVQ8WnMGP2YclzmGif13Fru62W9oWpeWAtnAq0BvXCj1SUMY1k5qcCqejSb9j8+pk2A09vMIry9xThHUl6n5g6mJuGa8fs0tm5wm8Xl69UGTh3qJaoEcPFrEySzBmlFZaMssywMvCBuUAKq3rum8NZ3Pe2eynUjtXD97xCEz2uOIqGMfab10BPUOhR104cJKuoGnhHDjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8106.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9GVmFCSkNpSHlQZVFsbkFMTGVIdXFoS01sMWVqR0R5dkdrK2RNNEdxVkxu?=
 =?utf-8?B?VitlQ3BnaHJ3c1o2NWR3MklwOG9iZVc0VWNGaUVqNWNvQ2JTQ2NUZXRzejc3?=
 =?utf-8?B?YUdnREpXdVhMMzRsZmlFYnZUMGhHUjBOR29QV2NYaWc4T0ZBQTU1Slp0czZP?=
 =?utf-8?B?YTJWMitZdjIvU2RET2VVcDVoWkg2cHFzZ1VBM3ZqeUlPZkw2d0RPMlhlRDBn?=
 =?utf-8?B?LzV1YnFJcVplakFnS0MxeUM1RWRsY1VEeWRxSVRoeHJtUXBjT000SnJqaC9n?=
 =?utf-8?B?bmtyWXpmRTJDMjZlekNCWmdPSk53MDl0QTN1US9xcU1DV2plMFdveDNCL201?=
 =?utf-8?B?c1dhUzU1UHlidGpNallTY3JrYnNTTlJnbzVoM0pwaGtqOVA5WlhvdDQ5Mzg2?=
 =?utf-8?B?RWN0clFadDdPNWFzTG5aR0xnQkF2YVBETUxJeXBaWGdlT01PSGt2dTRnV2J2?=
 =?utf-8?B?SkNVTDBhcEo2bkJmd0twbks0dHJiU29MTEJGUVY4dFNEaVArR0R6L2hiWGQx?=
 =?utf-8?B?aEZrY3JoQVNEaFZLQWpOT2VhdzRCd3BsaDZVbWpkRU1qTXNjWTF3LzVMeFN4?=
 =?utf-8?B?U2tXU1NJUkR2c2tqNzZuU01nUEVpblFLWDI0Y0tSamcvYzVNZHJUall0ZDJM?=
 =?utf-8?B?K3htZ0VNRlcybnJ4eWxKSXpOM0dLeWpCRk92cGttWGMvNExZbStkdUk4cHVG?=
 =?utf-8?B?L0N2Vy91S2g0NDdkZlkrOCttZFBmOWVoK2ZYRlp3ejB0N0FwR2RCbHFHeWRs?=
 =?utf-8?B?ZU5XN2Z6SThXYnVEZ0FBSFUvTGFUb3g0Y3phMThrOXZkSHY4V1hPSGxaM2du?=
 =?utf-8?B?WHhPNnk5QlNhUHJZMXZyZU55UHV0L3JFOU4yU2g0V2hzd0k2TUFTL0lMMFMz?=
 =?utf-8?B?YTQ5ZmxPVHFNQlBJYnJKNFNBL1p5eWJ6SkhTYlVadC8rYUVoVDA3dWM1eGgw?=
 =?utf-8?B?VVd6RGgwbkptNk5zVHVpYzBIenhZMldCazFoVzhON0cvTTIrT3pvSE9HZkc3?=
 =?utf-8?B?bFhtNXBLYk5PQTlseHM3NWFaT2lCSHlpWU0yUmpRaDJxTmtoMlhMN3FUb2RP?=
 =?utf-8?B?djRicnV5dEdJdWNhTnlSN2JzZlJ1SUZ1NVR6eVg3a1Z1OW0yYUpTMG84Y2kv?=
 =?utf-8?B?ajA5aXc1N3FXNmNMMC8ydU9GK3loenZld3pWMXB6WG9JV3FGdWw5czFSZTlK?=
 =?utf-8?B?M2Qvc1AyL3dkVkRqS3I3V3J2MW0zNjh6dHNxanl3SGdtQk9VMmdtZnAvTDdW?=
 =?utf-8?B?ZUpWYzJqS1VRMDhOM3pSR0VpVnlCYnljR0RnT0gwTWo1M2RtRGIwY3d0RmFv?=
 =?utf-8?B?YWloRWR3bHoxSkRwaG1TYmlFd1RydnE4NmFuSmtXZ3dTL2RNUjlhWGg4My8z?=
 =?utf-8?B?M3k1NDYzaGxVbkpCb2wzaDBObCszNklESnZaYWRwUHpiVjhQQ1FqZ0J6R2s0?=
 =?utf-8?B?UkEyN3RHVnIvSllWYTlUKzhIbERQaTJjZDhRQjd4dGNrOFBTeWh4TkZmMWxi?=
 =?utf-8?B?NWcwNVVCK3RHQURKc1VTV0VhaW0wWVQvYWlidk5kRmJZZGVTVTRLcEpWajA1?=
 =?utf-8?B?WmdTQVQ5TzJiUDg2UVVLMDcrdEw3QVZteVlwZUVsQjBvcnA1R2JQNnkwcWpW?=
 =?utf-8?B?WEk0Q2swN2xUUTd2YTl4MzFzdWFaN095L2duK1h0bk1GVFpVY0N5VFVuU3k5?=
 =?utf-8?B?SDkyOHlibHMwZitEaitXU1o2NDFFNnFaOHBDRmgyQkprVzZjRkhNdVpUNTBK?=
 =?utf-8?B?NytXTjZEUHN6Y2tBQ1UrZlg1STZNbnh3SmZFZXNKelJ5WlNBRXBSZGZPZWlp?=
 =?utf-8?B?cGdXQnNOamJ1MkZoZ2N0SGxrcUdUbVZ2bFdFNEJhMXBpS1k5cmI4OE9Vcnhz?=
 =?utf-8?B?RlJqb1QzMXdtL1NQdmpSckFuQ3Q1UklhRHhiQldjU09pYkwzTUlrUXZ2VmhM?=
 =?utf-8?B?eGp5ODNxejRmMHIvZTB2VUhmdmRKUEZsanpYYVQ1OXI4Kzg0NWNmcjcrL0ZG?=
 =?utf-8?B?SFZCMldNaWEyby9IY2d1Zmp6cVpSaHZ6TFJ4enlTMUdQSTB3RmU2U1lhSFFT?=
 =?utf-8?B?c212K3dEL0QyVzJYVTY4NkJsSlh2bXhrdi95anJxTWhhMWJnajAybjZ6ait1?=
 =?utf-8?B?RGhpNGQ0M2MrZmpMSGNkS1dWZG5iTlBVUm40MHp1Y1I2NmxKWGxlQ3NtR05V?=
 =?utf-8?B?YUJYYlRyaFRLMGhGeFhYYVh6VWJvVmpkMHEzQjJJZHByZXVZVGxBT085TGo4?=
 =?utf-8?B?OVArdkIwOE5PQUIzMzh2bnNmSmptK3Y1WStwQU9jUTNzNlQwNGkwN0ZwenpT?=
 =?utf-8?B?NkRTZmR4ejJNcWtiYTVxc1o5U0dyZktNaXQ5MzA0K21KWE1BZlRsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30f719f-3553-4d5e-dcf8-08dea54fcb89
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 17:58:47.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWTw3NoBnv5ig3TlX6KtElHm6pyZqr2SCG+nQOvzwBoy7TyBTN3lZ7ZmWHPCWh/nnyWYBn1aw4e/0xVclPwo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

Hi Joerg,

On 4/28/26 4:12 AM, Joerg Rodel wrote:
> On Fri, Apr 24, 2026 at 05:42:07PM +0000, Melody Wang wrote:
>> +void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	struct kvm_host_map hvdb_map;
>> +	struct hvdb *hvdb;
>> +
>> +	if (!sev_snp_is_rinj_active(vcpu))
>> +		return;
>> +
>> +	if (!svm->vmcb->control.event_inj)
>> +		return;
>> +
>> +	if (WARN_ONCE((svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK) != HV_VECTOR,
>> +			"Restricted Injection enabled,  %u vector not supported\n",
>> +			svm->vmcb->control.event_inj & SVM_EVTINJ_VEC_MASK))
>> +		return;
>> +
>> +	/*
>> +	 * Copy the information in the doorbell page into the event injection
>> +	 * fields to complete the cancellation flow.
>> +	 */
>> +	hvdb = map_hvdb(vcpu, &hvdb_map);
>> +	if (!hvdb)
>> +		return;
>> +
>> +	if (!hvdb->events.pending_events) {
>> +		/* No pending events, then event_inj field should be 0 */
>> +		WARN_ON_ONCE(svm->vmcb->control.event_inj);
>> +		goto out;
>> +	}
>> +
>> +	/* Copy info back into event_inj field (replaces #HV) */
>> +	svm->vmcb->control.event_inj = SVM_EVTINJ_VALID;
>> +
>> +	if (hvdb->events.vector)
>> +		svm->vmcb->control.event_inj |= hvdb->events.vector |
>> +						SVM_EVTINJ_TYPE_INTR;
>> +
>> +	hvdb->events.pending_events = 0;
> 
> Does this also need to clear no_further_signal?

Yes, the no_further_signal is a bit in pending_events so it is getting 
cleared already. :)

Thanks,
Melody
> 
> -Joerg

-- 
Thanks,
Melody

