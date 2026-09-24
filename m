Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012048.outbound.protection.outlook.com [52.103.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D803B5F48
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214664; cv=fail; b=A4kFxE3dSOL3XicXx14vr6udFzMIPYM2ov/z75m6BGHriW/oiz1mfydqhdHEdZBOSWok5Bhjj62w9m/8vIbIWzuj9PFs5jVSE2CtGvseWjphE8kDd58zQv7ixZhZcxSwwjPqz06s+6Bo7LxG/uhiqCBU1++73POV0ZVG2xj6Gis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214664; c=relaxed/simple;
	bh=SYoIhO8FTO898k7MAa0ODEtAGF9+1bNI2uDIUhtgeDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/vDFgnrE8uQBUK4+v8snTRSKNBKr8v96btHWcWT9l5QpPsa1l1KsyEQLgVbgJpw5kUiAxdsGBZ6WIB2Gp2h2HDAJbLDc9Rct+R6Zakx67LCczyJmKV1XRtn5n4RWqfQbPKdUtEjruWnJw1LUGEfMILuoGeBwUneLTydT3dm2yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lJEXwpQv; arc=fail smtp.client-ip=52.103.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lJEXwpQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5hiaLRt9iCi6G2puXSobh2WkaclKhPk5jRtewAzq3bZ1OWFzuyaJwpUfMzZwJx9vlrkfZucBw9jEAUwfE0O8vi7urPNWvrF1sGyy9Z8I8RR5sXuDVjL9x57HD9YkvFD25cXZmBFXLd8ibQIwh56qnkSHEX0p79ichU+pPjfDS5bV6OuQ4JbMY5ChFWhcmWnjstFx8oi6UEB5GOLBn7v7e6znCGjk+uOwfAoRcI3EoKdYqSp+uiujQkzDWJF8hBd9FL8U+3MOpw2DJaeLHHwoP2C7tgJhSwE/bGSh+HrnFQnUQCcgdjc5P0fHrS2xfMC78qJ5WiqK3SbVFKZhGDdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9abixG0uIwN2AzLnd2/rXblv/j8ai/ADLB1tfe9itTE=;
 b=boMYLVnvyXqsQKcWBeEBnRQjyX50JkLH5o5lE2rpuCAtr0J2TkfTO99mgxeNaj+xx22Qbu4RhcxTBlcpXlRUBqcvkCidlXD0IYHS/l/7L+Xi6zAIjGK15lG6127fqs/iqn/OnuFCAAeit61/iJKDHrw3DTxwjrJYGK+9hXXhOCdhbtnWV3iHGIyI3ev5kSOTv+qLUoXLBVxNR1eGje15eSDbS3Z3OL/jIzk8P0R5YrYOLLOpJpQYOAozItixvplh10ahS0lfmtf12ED4BrnYPFymJHisMfeE5CtSb5u4C67v5HPNwpQKF/m6LkFqjviogdzV3oF4oKxiCRaeCKv4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9abixG0uIwN2AzLnd2/rXblv/j8ai/ADLB1tfe9itTE=;
 b=lJEXwpQvqLmXLcU7m00ZysrnaOc9ztouMCRtM+Pt63nI8SRBmKOqZ7N/ar5yFnOj/LCC/NmAhmplZZAk/ykF6mC/COZ3mD5nH2RIlJAQWkZdtjhMfXs4X+miHRzUYsWAI+unupXqza9/BB0j91Hm18EEDfTeBKZ3cGhGJcggk+lG6+BS98gVBkdyShaijyIR/XAZ7gCoqckTiof3bUr27qhC5ECsCfE0Gkx79i5QixVI47ucIoOH7sW0qBlnsZ9IyrCahhSZt8Dpbr/TOisYPYMemqZWd8Qlk4DOVhns5DdKJwAtlpjs1a9IdJS+zvIN8PYT7AVt5wvvw5jxz+HSoA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SI4PR01MB7982.apcprd01.prod.exchangelabs.com
 (2603:1096:4:298::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 01:50:55 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 01:50:54 +0000
Message-ID:
 <SI2PR01MB4393F419F425D1D54C389A54DC812@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 24 Sep 2026 09:50:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API for
 confidential guests
To: Peter Xu <peterx@redhat.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Steven Price <steven.price@arm.com>, Anup Patel <anup@brainfault.org>,
 Samuel Ortiz <sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
 <jakub.ruzicka@matfyz.cz>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Vishal Annapurve <vannapurve@google.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Kai Huang
 <kai.huang@intel.com>, Kishen Maloor <kishen.maloor@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Peter Fang <peter.fang@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 kvm@vger.kernel.org
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
 <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <d7c1d759-02ce-4a59-acc9-d5cbf68cdedc@hotmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SI4PR01MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 883d8cd4-aec5-476a-28fc-08df19de4426
X-MS-Exchange-SLBlob-MailProps:
	q6Zzr5Fg03EuTjII8LIIKTD3uyhoagb3c5iVLatXaCuA5+JnWQIax4vxjSlGyf3McRybTlgGsc3r1Q2eJFGXBF103gr/sKmLmMzwr0+OM0IcCdsysZjMkgfleO6GWmOh2yZK/Bz0EWwIco42/xewKK+UYgdAE08wltCM10NKmaO2ud1A1m++cZ0YXj+LlpiMIj1xZMjpfeHdItU8TcnBRyeQq7xY0w0A2vRqjdB+TQDyk/9EAfQa5QywJYE18grNiHkAxQ4s5KP5IilXF6Xz0MykYmAysW2jCZqgifjw7sqqPjaJ0wm2E8PLUPHuljriuhGz6wp7pbPuZKYmPDb39rqesGQeAIcFnfcb/KirYv4VyPv+j/Q1XZPN3Ea5LyklBWIEBkuTqWHlOo/PAgemqJz5+OhMPV/LQlFl+0Z/pXBMbEHqRXR3Ycbu/To6eRJDsxT3CSWcz66FP+MARkBz1P1R+2MHOohmbqCAxJiDCgMxKr5XMATHzWetgCQzMNcdFOFGg/oyQgGmtQpJ96qLlFhDRTLFILSftnkROCofpm/wERRk5fxs2zJGVkNU8u7nU1G1+XsCNgleKG7KMPyzXC0UOM1AxaK+RvJ9zLEKBuAt+nNFvOKdf3dNjvMp84GNdeVScD1WTSxCuzmu8pKN2iMH5gVwk/0PfUz2Lw6Ka/mX98rkfTF6hMuqUGT8kW3M
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|8060799015|7042599007|15080799012|45011099003|25010399006|37011999003|4140399003|5072599009|16041099003|23021999003|440099028|3412199025|41105399003|40105399003|53005399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWRKYzAzZFBEL0dId2t1TDBvV1RYUXJFQXNlR205dWtsQ3pSRit3UHpoa1Vr?=
 =?utf-8?B?azd0dy9UMkNkc2ZsbHd3OFFZS1d0cEJucHdGTm10Uk9rNmR1bElGRGp4WGFS?=
 =?utf-8?B?R0xDUlNUbE1TS0hqcXRPV3hQR3RiWFJ5R1l0NGs5VmZ4TnBSdi91UURXWFJy?=
 =?utf-8?B?ZENhRUFuNlpDNC9zQ3hVVjJXaG9QRm1XVTZxUXNCV1lIVjlSRE1ES1ZqRW8w?=
 =?utf-8?B?eXlaRVpNV3hkTWU0bmlGTlpVVHdlN1NQcmM0eUJraUJua0p6UjZuUFpsbTJa?=
 =?utf-8?B?eG55dmtnL1VkQ3dEeHZSSWRNM25DQUNmVnVNcy9UaktDVisyaHBrbkZxMzk3?=
 =?utf-8?B?YUtXdHlZS01LcGFveWJKSFo2UTZQQmczdlpTQkhVdmY1VVMxUU5XVkZiVTlR?=
 =?utf-8?B?Z2VJVTNveWlyQitBSTlCVmhTTFNSa2dpQkJMdkUzQXE1ODltd1hVZWFqdEFK?=
 =?utf-8?B?TFZMSDVkcGtwZVo3eEdXWElzNVl0Q1hrNlRCem92eW9lR1RYSU52L2Foa2VI?=
 =?utf-8?B?RmxFdjVOdW95eHdheXJ1OTFnZ2djbU81S1E2VDhXWGYxcWppN3NacTdxbFpq?=
 =?utf-8?B?WExFM1F3bllVeGdmRkxvTHdSRUF0aEJCdGM0VlFtb2VLa3padldGdWYzaWRv?=
 =?utf-8?B?UVhPUjBZSkFEUE92RFlCeXdkVkE4MUU3U3dPT1pqb1luMndRNVlzS1MzVUFj?=
 =?utf-8?B?K1M3cjNDZEo3Q3pTSzJIaVpJZzVhdGpkTklpWmxWdEdyckF3dXNmRmYrOEJa?=
 =?utf-8?B?bllaWGE2eWdGbE5rOUp0WFBSQkgxTCttc014cUI2cUFUdC93N3NFNTFmVFh4?=
 =?utf-8?B?NXpKd0ZKSGhGcytaU3AraHVkT3VXc09SVzVvbWpXbkhwTGcra2g1Sm1hdmVw?=
 =?utf-8?B?ancyZkRWa2N4SitwZEl6aFZyaEYxZVpwVlJyRVdtSVlnSmtnMTIwZy9uMmVQ?=
 =?utf-8?B?R3F0cnhHcVZJVFRzQWhDcXhhTzNGVE5RZ0lWUHJidGVGdlhMUDAwZFk2cFBJ?=
 =?utf-8?B?Rms4N1pkK0lYL3AwMXh0Tk9ra1JUVGxLVmM3ZElMdTkzSVZZWnJxN1FLMENj?=
 =?utf-8?B?UmNFeW8zRmhpeUlDRTBIakJ0OVpSRXJ5Qlp2VkY0Nm1acUc4UGxDRWF1Nlhp?=
 =?utf-8?B?Szc1aitLdDVJUGQraTdBTzM0Ti9WTE1mejVJWkZsRW9rdjhTMkhURXEwbERo?=
 =?utf-8?B?T2xxa1NMM2FQdFFqRHlDMEluNkRJUkt6M1ZwYzU2N3ZwVGdabTdyYlFudDdZ?=
 =?utf-8?B?Z1NQeWVFbWkvV1B0dXJFVkdQYXVhTTB6NDdWdFA3RG1pMTdybFhuVHBnalpY?=
 =?utf-8?B?dkkrSkg4RUZtOTFpOTVDbXE2ZHZ0eEhxU2k4RXBUdEJaNlQwc3VRamppenR2?=
 =?utf-8?B?QkprRTRQaWxScXRpRkI3OWRSMTFmRHZvVHhhRC9RbEdZbnQzZGFHVHJ2Y3Uz?=
 =?utf-8?B?U2Fzbjk0SS8zRmZnQ3FQYTIxRkkxUlY1bnpJZFBBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JsVjhORDFRNnJTdWtGa0taSEQzYlN3SlRUYWcxaUxnd2VndkpIdnFuS2JH?=
 =?utf-8?B?UTd0d0V3d2M0T0RvSXJMcTVSdkwvb3hpcjBKeVppK2prQmxNWlZTcm54U0I5?=
 =?utf-8?B?QmpSdlo3SGo4d2pFa1pZOEd3L3hyQWxiMHdsS1orMSt5MFo3akdoMFo5SjBr?=
 =?utf-8?B?RFVmQW9ERkozc2l5ekJjdUN5NFNGRFNJYzB0TzhFcjZkcENsZ2dUTE05aWdx?=
 =?utf-8?B?MG5jL0h1OStMZitoN3BqZkZUQnJNYnBwNjVHak5kVDZRak9kSno1ZlZzSEtS?=
 =?utf-8?B?YkpSRWxIazgrYTFaY1VTQTAzMnlvWlY4OVFOVjIvYTE0Q3V0S1FqdzU1eFRG?=
 =?utf-8?B?VzVRK1RQWUZHbEEwSVplRmNIc2N1RThObElSY2ZqOC9HeGtpdThDSW5yMlRL?=
 =?utf-8?B?ck82RVhOa2Vqd2ZDNGU0MU4rTno2dU9DOVJhUTN4L2NFRVRvM2xVYTdXbFJi?=
 =?utf-8?B?cHAvaFJLTnQwRTJZOU5DS05IRCt0K2JZaFZDSzQrZFBRUVYvRmdkKysyM1Vp?=
 =?utf-8?B?ZGJKZ2ZFd2hIQ2EyNmJqUXBINjM3M0kyMVhpRVZFdEZQVVJ6aXVEQ2o5NWpV?=
 =?utf-8?B?dC95dU0zNzZ4UW55NkxYaUg2T0dBVmRkMHlhN1NwaUhQMmIyRmR4L0Q4YW9F?=
 =?utf-8?B?VzMzc3N4TS9yZW8yN0VCUWpldVhiakZyMEVZcFJQOURSMHpwNnRXbjJWYzFy?=
 =?utf-8?B?ejMwR1B3eXVGZVNIWVN2TTFWdm5vWkV0WXBiMHg5QkkrQVlwNm9TeUJPaUZJ?=
 =?utf-8?B?Kzk4RzNFMStCcWVwMXJHTnpRMkNTWkJ6d3hCRUsxS1FWYmxZZVlsODZCWXli?=
 =?utf-8?B?U0dWamtCbHpQN0xXL2xiOVd6N2ZTWVhUMFkyNmIrYmU1MFRadTNuRWd5eU1s?=
 =?utf-8?B?TTlzMmQrSVFkNU01MGg4SnlZUHNORjFyWXowcVhDTEdSR0V6K2dvUWVGVzR6?=
 =?utf-8?B?UWFFVW5zSGljU3JPSVNqeVZwMDk2RzQzdGFxNkZabWZKcCthNERYSXN1WFNO?=
 =?utf-8?B?U21xNVdYb21Pek1ENVB3a1F4L1YvQ2JQRDhYQlpaUFRQNjRraW5UTFFuNE1z?=
 =?utf-8?B?TVRMY1Z1Qkt3TElucFkyeUQ5SVc4UHRpdUdHc2tqWlhCK3Y0QWRiQ0hmaW1u?=
 =?utf-8?B?dWZwUERPQ2pBQnl6RWVvL0pIelFFdDBVSVlFWktEWlBFM0Nac01GdE5UOXVh?=
 =?utf-8?B?UGNBYXpQcUEzdlVwZVlUZDU2Z09vVkZEb2puTXIyS3JnYWJZVnVIc0NrZDR1?=
 =?utf-8?B?eWdSVDkzNTFlQVBpbnRWbDNBSU5CZlZyQ2pJeWJXZ3I5ck1tRDJJQUV5QUdz?=
 =?utf-8?B?Q0kwMmx4MFR0V2x4MitWMWFwaVJHbXBaaE9PQmZQNzdGTjNWZjBQWWk4citP?=
 =?utf-8?B?TjQ1WXVWS1FrS2tRbktTcUw0NEVlUVRYWmYxQldFMVlYNEM3SkhqYjNUOXNR?=
 =?utf-8?B?dzdpRzVKcWdKdm8wOFdydkdCS25HSWJIT1Fobk9OOTNoQTMwU2V4TEl0YVVk?=
 =?utf-8?B?eEVEMlRiZm0wc1BCeGR6QW1JUDVEUEs2eGhYTWM1aEFwTUNGNXhMbExETXFo?=
 =?utf-8?B?MVBFLzAxU2tpa3IvdHIrMmhZVlQxWWRSUjVvQmRHV1VSUmFkTW9ibkRBejYy?=
 =?utf-8?B?SWJiWUZ4UlhOcHRsM0lrQVpva2xqbDQ1MEZmSzVkUURsMTk3bVBVajlSTUVn?=
 =?utf-8?B?ZW05Y3RYckVEdWpxY2JRSysxQXRQZTFlQWRFbmdycHNQWUFKNVNKcWJKNVZQ?=
 =?utf-8?B?OERMYmlNSVNLZnNaSzVleGcyd25VdS9qVE9maWZqd3JrRXNIRUxldWNvYysx?=
 =?utf-8?B?TWlSOUpxTy9ZVEV4RHlibUhlOXI5cS9oc2xUTkc4NDZPK2F3Q0hoYmJ6VEFZ?=
 =?utf-8?Q?on3tJNw3Wup+7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d8cd4-aec5-476a-28fc-08df19de4426
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 01:50:54.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR01MB7982

On 9/18/26 7:35 PM, Peter Xu wrote:
> On Mon, Aug 31, 2026 at 10:13:01AM +0300, Tony Lindgren wrote:
>> +:Capability: KVM_CAP_LIVE_MIGRATION
> 
> IMHO this is slightly misleading, some "CONFIDENTIAL_" or other prefix
> would be nice.
> 
An earlier version of this series used KVM_CAP_CGM (CGM stands for
Confidential Guest Migration). I think it's cleaner to use a short
CGM prefix for the related uAPIs, so they're easy to identify as a group.
