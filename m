Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022125.outbound.protection.outlook.com [52.101.43.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A44391E7E;
	Wed, 24 Jun 2026 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283386; cv=fail; b=U6qOvqYVYzwj/VAcwtmnh5GQH9xBF+XBNUEu8sIRHDy3UQ1unzKNA+7odWUP6Fna+A9RYPB0HXS0hVm5695cRFHUtI1qT16AEgT4f4gl1YAwWSKLkGeh/zZsY+QRGpC7lL0TkX/ZD30XUlkaGZi38Z2zkgv5B+rTA/X6Pth8B4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283386; c=relaxed/simple;
	bh=nv86sowtQeXM81MY4wzFtf1VSOTaLyxxtk38wWo76zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imwtfDGlod0ACkyvyg4YfjQgroSgij57lmIrMkj91GDFHnQeXbezV+2vx2HicHOXH69s+XL37J0Yri4yotHetnCBaHs81e96IskW4iI1STH3Z69V3dab00haSL5ju9+alV7khwb9lKq3XuYXKXRXX80XxqoDPM0TKEmnp34jTe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=QT3Ii5Ga; arc=fail smtp.client-ip=52.101.43.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="QT3Ii5Ga"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb8qN++PufQZlIu+u2T+vCF0w2KmHCdro7Oq/rR/tU1LQnrRn4yFnpu2V74jKbkoKICbGBfTX5pC3K04xItF749VCgutCaXc2AdHSd/bekLE/SbBTwIZD4sE62K4ZlR4YRqc/6ffw15+gFY0o1ijVLyaA9CaNNFGEv/dxBdMlGt1cOih63sJDXmGiWWeKpYc0+zlmCJElSMoSRNXXzrIR58w9+cBtLzc/WanFaReLtN3YCJtlKwrPDmP0DvB4XKmqzxy0KtopLPvMacgvCeKfaw3H8ixIwn7RTbPi+5pzsuSmE5P08X4FfsB6NmklAr1nMC29xMYxgBN3GgOZ0LC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxduWX/fnegYqA/zxY2vuqsWHSeiXOpxeHbzoHa68vo=;
 b=R0dGFuITXMDfNSg0TKCZWxmc8s2Mp/plj4Cn2RAPh+EhyHtdrBTHZqv82bXme9f8MZGDTvCxUJhsnP7z7lgsiNmqN8qvmtV/QBZvo3QiojV0XSZ1nuLjt6a5Y6L2wotZux8es82i6LkZ2Zv7A7WqolCvqX6NNR14r3WpIbzal8qqMJgStl8Uk6bo+Pe863PYxan3gofQzqdz5w2dP8Wa6BNyKCGeufkrrPwokM62BkD6fUPMWYj48SIJeLNy5CSDtccbkR21hGMOTN+Ba0H0NBN1Yo/sO6kPGqZR8k5w0irmoT2Mhxtt+och8igSekVq+bG4w5tXuqbSFDbsgb1ioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxduWX/fnegYqA/zxY2vuqsWHSeiXOpxeHbzoHa68vo=;
 b=QT3Ii5GaPg5kFmOeGBlAl/rk+LZACbcF2tR1YVlUfEB3EwaAG5CnEf80HtbJ367wHaeG7jF4YFrmL43UHPReSRhAJJLEoGNiMBsU4Ro5e+2jbWbX5uujLTkSY2FZDiqNSBz/+wwTcJMSrxpEuokaMWYcVD7K37IFr5pWKK2WyE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by DS4PR11MB9529.namprd11.prod.outlook.com (2603:10b6:8:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 24 Jun
 2026 06:43:01 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 06:43:00 +0000
Message-ID: <586e6728-d364-4da0-83a4-95082d07de69@fortanix.com>
Date: Wed, 24 Jun 2026 08:42:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support
 KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
To: Sean Christopherson <seanjc@google.com>
Cc: Jon Lange <jlange@microsoft.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, "thomas.lendacky"
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>,
 Joerg Roedel <joerg.roedel@amd.com>
References: <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
 <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
 <ajsCdRhFEw2pcIXx@google.com>
 <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com>
 <ajsO6SLATtDsXYsZ@google.com>
 <89c4ac3a-1462-4798-a700-2e1e9407a4f8@fortanix.com>
 <ajsaBBrsIbM7FISl@google.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <ajsaBBrsIbM7FISl@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030102090800090909060305"
X-ClientProxiedBy: AS9PR04CA0151.eurprd04.prod.outlook.com
 (2603:10a6:20b:48a::21) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5626:EE_|DS4PR11MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b204839-2046-4547-be64-08ded1bbd54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HtW5ZTRQQ333AA4tt+peh5djCZAkevnKaeGnm2jvSkPWeh68cAD02C99rRoNhIsBUK61YRop3Y2gMXGVtjdh5FM87bN1UEg0yodnfSFPBsf1GmvjTOaOrkGdWIA2DlYbfw4SXKynAxDawpMXIhk0Yjqzt9ovDLDLfiftjvSDBl37YcwXHdFVdsiaFkLUnVkEmu7Vnr7jaR8/4Kt+Vq+SM44JJOeZ0EWVmmtRei7xywlLQSfom+S3sLY5NhDUKZohYdSFL6It4luwTO9X8ZIU3OdMWUGS79np7XdbJFeteB+EJOWwtKuwWo9lGTr0/ur8dz9l7NcfrolEj0kIPqz5pSAxR+PQs/rgXp6ZuCDDZWZkisPxSQ6R/XWEhMiIUk9FNSNArrsW3I5uvaph9Cd3VDbf4+rUEYbXAQsUIz8W10JNFjFUq/9BZ8sNnOIIAE8De6c2q87LGJUa/uOsZARAoQTMDF3ynOwiGFFgJQet+Bkrq5BZH5n/G5oE9PflHDEGMhBsJr2QjP+enSnWrsUn0dCUrFulYIvclQf9Z9LSmYpvw65nSGM+KJ5DkrLKj8qMZy51Vr6978wHGyGcUiZWiMkr7uZD5MRcdQ83TUFR47XMdB1gIKGob+YVkp/z8MqDaXzYJMRai0UJxlmAN8HnymQf+ioYmYwnkeO6R1OKvus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTVEQTdRdDB6cGRGR1lCVTV6V1U2OGZsbkxYdUVOTXdnRGxsdlFnN0UrOUdB?=
 =?utf-8?B?eUY1OFFTSndtYjkxZkl1dHB3dW8zejhuTjI1T0FNK1MrTzNzMU9mNGZwMXF1?=
 =?utf-8?B?UDVPeGdEb3pPSFo3RzVQMEt5S2VOWnBXSmtKWGtKcUZSNytMZWlOL05Mc2Jv?=
 =?utf-8?B?ZHh3OTUwbGpHV0g5ckE3cVJQbWttWnMzQVpXQ1QzMFhiWXM3bXFUYjRYSW5S?=
 =?utf-8?B?aEFoUmpkMUQzTVZQenVXOTE1cjBLTS83elphQkJEbWZHRUZoWUNtdDVXa2Nj?=
 =?utf-8?B?dVYrckxSeHQ3akhWZWlEVmJJcXhuUU5zU3lsOG5VMkZrNmFQZDh3MVBRZ0l2?=
 =?utf-8?B?cnRHRWsvSnplOGVMWkx4VWcxOWlRRVB3ZjZOOW9nM3Y4SkQ1S3h2UlF6K0Fi?=
 =?utf-8?B?aUZGT1lJdkhCeWFralFxVkVleVZHS01SYVBieDlzTlZTdzJ5RTZOODZsTVc2?=
 =?utf-8?B?eGRVOURDZWJ1dHRyRlNIQS9BZkhNQmpYNk9WVmhzNFZqck9OWVpicXl2S2Ur?=
 =?utf-8?B?OGl1d2tnZm5IQ1VnWGJkditHcjQwdVNlbVBiU0ZsWldFWHVuYXQ3VE53VE5m?=
 =?utf-8?B?cUY3RTVzSVhIM0JBbmVHV21ZTHdFMEltTjF3Z0cxV0tBZjNNRlRYMTJaelFp?=
 =?utf-8?B?MCtycWRXazlHT3h6czQybFRRbFZ3VnRhdlMxbHg4UnE4WVZ2d1BTWVZ4OVhq?=
 =?utf-8?B?Q3Fxb29MV0hCVzJCelNNZHlwcVJjZEMxemZvUmp6V1owdmNlOFl0czV0UHZS?=
 =?utf-8?B?K2ovbHByV1hjY0F1WVZPNDFEYUs3amlvWWdTcE1zbURUU2c2bFVCRnFXbHMw?=
 =?utf-8?B?cVhXYmJSZEpaak04U041QWJuYjJwUmF0K2NCSTdDMk5ueER6QWdQNjI3NjRG?=
 =?utf-8?B?dTEzRkFwa1ZDNnJQa2s2ZFE4SnVjbW0ySXJ0RUFlRDc1ME5wanZHY0dHRmpi?=
 =?utf-8?B?UGNOeVZKU2ZmN1g3MmtJdVFJb1YwQmpVMEZ3d3ZyakhZblpvNGRPVEtNOUpJ?=
 =?utf-8?B?aG94QkowNm1obHNpWXJTUFlOazBOODhjcW0yWE5GSmVBQUpGclRONzhJdXFM?=
 =?utf-8?B?bVdHZVI4MEdqUnFLSE9jeDZScStNVkQ4RlNyQWhkUlR3RXlrVkRLSWN3WFp4?=
 =?utf-8?B?VVhENTJ4SEtRSWY4R3Y3akNtZU12Z3lHaHE1V2JmRjhIQ3QyMHhxbUNDdHh0?=
 =?utf-8?B?SHhNSWs3ZU1RTUpSVkk5OGZYTUxiL052SDA2S0FFRUx1SkRTdXJ6azFWZ3lU?=
 =?utf-8?B?L2F2bDZqc01WVmJWbnhMcVUxVWRnYUdSVHYrTlZGbGVvUTBNRWpPazNuYmxj?=
 =?utf-8?B?czZ6QTV0WVF6U0YrYnpMaDFRVDhtVllod3V3aGRieHNxTXJaRWNReHdDVkl2?=
 =?utf-8?B?WTBnK3RDbVhKUVV0aVphLzZBZkxZZGtMNEhNUW5hUi9XT0JLY1VVamdORFdh?=
 =?utf-8?B?TWs2QStQbzhNSlZJUzkrK3BZNHZUNnhqTTVJbEVjWkIvb1VhZk9GVi9hWm9T?=
 =?utf-8?B?dG9IVGxwVXZZTEZHTlI2cWpnTmxKamx4TGQrNUJSUWFvRnhMVENqZmdYVWFs?=
 =?utf-8?B?MEliRVFXUGkxcHkrdkV3WGFUNFdlYWpUcWNNZS9DTEVSd250VFJpL2dYc3hw?=
 =?utf-8?B?c1lNVnZhUmh0azVqcnpldEdyaTNJWTNHaVZTVDQwSHQ5ZmVLN2VnVWlNV01v?=
 =?utf-8?B?UjJNWThiVFRDNEFlVTJ6MFpNNWk4Y2xlc0VtZFhFRWlsZzhGblhlSmlNTktv?=
 =?utf-8?B?dTB4amRJY0lHWkdYZjNGbjB4RHQzcVY0amZUTTBmUVFTUnFlRlI3aXUyeWV3?=
 =?utf-8?B?R3d4blBNbUhqcmgzbTNHdnZXUHp6QkNuQUxrZ0N5eFliUmQ1MkJmOEdqT2pw?=
 =?utf-8?B?bno1a1BCekU1OUtXczJnTjN2ZnluRG96akRvZVMweVZiS0V3SXpWNWlEcWxI?=
 =?utf-8?B?VXZmQ1FDTEtKR3NBNWZyMnkzblVwb0dpelFMK3Y4OXd5OWVhd3d5cHo0SW5r?=
 =?utf-8?B?WUZJUWE2Yi9XckIxTFFIRW5memZmY3E1QXYyWU5iQ3c2S0dNLzlUTXVIV2dQ?=
 =?utf-8?B?MUkwSjJWR3BjRkNrdU5rNzJHMi9EM2VpS3RTRCtWVnJ0YVE0MVhhQ2VSSVdJ?=
 =?utf-8?B?VHNWRk5IbWQ2eXFoUCtRNXZzS1llNXc2dnRnUGUvdEJmMVhKbStScGNuQzBo?=
 =?utf-8?B?Mk9pamtnVXpDZ3hwVUlvcGtQY0hYb3dQbWl3bXJIelMzdTdIMjhRd05FWGgx?=
 =?utf-8?B?Z0tFK002VE9zQU1jZldkZkRFK2lSTU9HQXBPTWZrL0FaMlF2VTJGR2FZbUt5?=
 =?utf-8?B?VFlhTGZvekFkYmZadEdic2k1Uk5iVkNweWxYY2pZTDRpU3hUeXZqQT09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b204839-2046-4547-be64-08ded1bbd54d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:43:00.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W07wXipOkJKjsheeLmnedUn68LCu2bXa781iU9SVUGfT+r1Lr13w5DEpRuS1pkdgCYyufOz8WmgJm6e8cUCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9529

--------------ms030102090800090909060305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-24 01:43, Sean Christopherson wrote:
> On Wed, Jun 24, 2026, Jethro Beekman wrote:
>> On 2026-06-24 00:55, Sean Christopherson wrote:
>>> On Wed, Jun 24, 2026, Jethro Beekman wrote:
>>>> On 2026-06-24 00:02, Sean Christopherson wrote:
>>>>>> A UAPI that allows creation of all architecturally-valid enclaves =
for
>>>>>> purposes of measurement portability was stated as an explicit non-=
goal. As
>>>>>> this is the only stated purpose of this patch set, it should also =
not be
>>>>>> accepted.
>>>>>
>>>>> No, the stated goals (thanks to the follow-up from Jon) are to (a) =
support VMSA
>>>>> GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and=20
>>>>
>>>> As Jon points out, the VMSA GPA is not architecturally relevant, so =
any
>>>> enclave can be changed to support a BSP VMSA at 0xFFFFFFFFF000. The =
only
>>>> reason to "support VMSA GPAs other than KVM's hardcoded, arbitrary
>>>> 0xFFFFFFFFF000" is measurement portability.
>>>
>>> Well, that and hardcoding 0xFFFFFFFFF000 is bizarre and confusing, IM=
O.
>>>
>>>>> (b) to play nice with multi-VMPL scenarios in the future.
>>>>
>>>> It's not clear to me what multi-VMPL scenario Jon is describing that=
 requires
>>>> custom VMSA content/address at launch time other than measurement
>>>> portability. It's currently completely possible for VMPL0 code to se=
t the
>>>> VMPL of a VMSA or create a new VMSA with VMPL>0 at any GPA of their =
choosing.
>>>
>>> Sorry, I phrased that poorly.  It's not about directly playing nice w=
ith multi-VMPL
>>> scenarios, it's that if/when multi-VMPL support comes along, the BSP'=
s VMSA for
>>> VMPL0 will likely be the only VMSA that is NOT in guest memory.  And =
so supporting
>>> an in-guest VMSA for BSP VMPL0 would provide consistency on top of cr=
oss-hypervisor
>>> compatilibity, and I place a lot of value on consistency.
>>
>> If the goal is to get rid of the arbitrary 0xFFFFFFFFF000 GPA/put the =
VMSA in
>> guest memory, then we just need a vcpu ioctl that lets you set the GPA=
=2E
>=20
> That's more or less what I suggested[*], hopefully by piggybacking the =
AP_CREATE
> logic inasmuch as possible.  Or were you thinking something even simple=
r?
>=20
> [*] https://lore.kernel.org/all/ajr1r-PAiXMnZ7x1@google.com

This seems pretty much in line with what I just suggested. In that messag=
e, I didn't realize you were already suggesting to replace the entire pat=
ch set with that ioctl.

--
Jethro Beekman | CTO | Fortanix

--------------ms030102090800090909060305
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZmljYXRpb24gQXV0aG9yaXR5IFJTQTAeFw0xOTAzMjYxNzQxMDZaFw0zNDAzMjIxNzQxMDZa
MH4xCzAJBgNVBAYTAlVTMQ4wDAYDVQQIDAVUZXhhczEQMA4GA1UEBwwHSG91c3RvbjERMA8G
A1UECgwIU1NMIENvcnAxOjA4BgNVBAMMMVNTTC5jb20gQ2xpZW50IENlcnRpZmljYXRlIElu
dGVybWVkaWF0ZSBDQSBSU0EgUjIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDm
Q+3UxwVE9dAx75DUrLZwgASWLLr/ID8bbGCfpcrSHIRsrR4ut5n49JGViu5DYE6addkpajbi
MA2Jaw1Ap4RncDjZ+0fzSWbqGKEE+vNPVLoKy7OVIrxf/9HzGUT6YaELSNrGTR0cYNcR+W5b
E3JTxTMQiLMAwBbMXH4qKXQUT+oyIXD11CIMUtM8ECoo2o7qdpw1zaZWwVvhXy9mkAaRgrkw
2NpddZUVbJKF/spsJa3lNVdSi3wcJpDDQAl6jxtBF/3ctkY1OjBQz32yRlArFymsPc+we9ff
HAgvfqbHVfXvgWG8urVith8/6MjmojHMCKqFoJueLbtTPoN8QhvVh49uoRYYAUUH0HOAYCOz
GBGrdJvMIYZqQsX90XlU7Qxp1En7vMkQswkQTvGmBPWrK/EwSAJc15BZm+i8QBxPqVKFORfL
ETLEC4ZrwomtW/oPxBP8zXPvQ0K1dQzAkw+JXxKv/KiwDryFFhU5xMMB3yKxO5NRYXlnqW9n
wfhdBTJScthzAtGO9KZQ2GPmq0NMVMuXe1XdCOmnPxOptKkMldBItkaYgrkTzqP1nzIAhVfU
4sNnHIxKPftwrZ9VMSc5Wkz88bOtAJyz3KQRY0qcAtR4LaeRkiZaEmprQA8EOpdJxtv03pBZ
taUnnTY6DsEwGQ0+P2mmB5IHB74SknyNswIDAQABo4IBaTCCAWUwEgYDVR0TAQH/BAgwBgEB
/wIBADAfBgNVHSMEGDAWgBTdBAkHovV6fVJTEpKV7jiAJQ2mWTCBgwYIKwYBBQUHAQEEdzB1
MFEGCCsGAQUFBzAChkVodHRwOi8vd3d3LnNzbC5jb20vcmVwb3NpdG9yeS9TU0xjb21Sb290
Q2VydGlmaWNhdGlvbkF1dGhvcml0eVJTQS5jcnQwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3Nw
cy5zc2wuY29tMBEGA1UdIAQKMAgwBgYEVR0gADApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYB
BQUHAwQGCisGAQQBgjcKAwwwOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDovL2NybHMuc3NsLmNv
bS9zc2wuY29tLXJzYS1Sb290Q0EuY3JsMB0GA1UdDgQWBBRmj6a8t5Msnfm6SeVP3OqQUBFq
nTAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQELBQADggIBAMJr11ncGIPKbaZxuuU2P1TG
yXF+gy+xH2TBNWNliJVL613nH1J7L2WcJQzqXYl77rKTzGeQexnKeYZ13MFwuE80vISif/gw
K569WLoyCvNVvGEZ2bZ+JL5K49mVhrv1gqO+MgMvc8iEENl1xoWRpJGD4EClk8t4u7NUCgBv
hYORiyzHCZcILHcEMvfEwmmFshMN6TqcAJdRjFT0Ru0hJcs5d7EFdM9dCa5ckXWrKK49cSNq
4qOaxqpG99EfDw6U2c70YcJ1/IhC1wL6z8qlGvhYQ0vJvqGJqW/DdeuWcMmrB+qZL9WbORQ1
nvlNggB6smEk0pXXYBr8HYjxT67XwtBBmkBXFpa7G6y4P0BO3kxWGBfvRBJHfyaiwREgVWa3
6V/WjXtPmV8VHcv04Rqgk64E4OlSUxgi9k9VC6kivTXJN+Gg2uJJBQdf+ptVhJqkkrtB0gAB
F+kQP0xsagKkrS3NVrVKo6peWMx0h7l52bGqT8ucu4Qe200KQi2xp/r8jpP60EE9U4M8D1gr
H3Kh9OxVOL4wykdoC/yGJNLKIl0BfsCVWB/GeSq5hxe/84K51OEJqpjDnOMrkRevfVzqGBFF
Aeg7Kg7uSysVR05wR+ltp3ytaIbjGJtKad8raIbM1qiNFErG7YB7v4baI3BP1s/rTDtPLoto
tahwHP7IqOHOMYIFVDCCBVACAQEwgZIwfjELMAkGA1UEBhMCVVMxDjAMBgNVBAgMBVRleGFz
MRAwDgYDVQQHDAdIb3VzdG9uMREwDwYDVQQKDAhTU0wgQ29ycDE6MDgGA1UEAwwxU1NMLmNv
bSBDbGllbnQgQ2VydGlmaWNhdGUgSW50ZXJtZWRpYXRlIENBIFJTQSBSMgIQNfphqrZnvSlG
TcM/9wjbxjANBglghkgBZQMEAgEFAKCCAxIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjYwNjI0MDY0MjQ4WjAvBgkqhkiG9w0BCQQxIgQgZYhk/M57PpOl
L7rByzX5D3paVQEV7ezVUOyqVYFGib4wgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
EwJVUzEOMAwGA1UECAwFVGV4YXMxEDAOBgNVBAcMB0hvdXN0b24xETAPBgNVBAoMCFNTTCBD
b3JwMTowOAYDVQQDDDFTU0wuY29tIENsaWVudCBDZXJ0aWZpY2F0ZSBJbnRlcm1lZGlhdGUg
Q0EgUlNBIFIyAhA1+mGqtme9KUZNwz/3CNvGMIGlBgsqhkiG9w0BCRACCzGBlaCBkjB+MQsw
CQYDVQQGEwJVUzEOMAwGA1UECAwFVGV4YXMxEDAOBgNVBAcMB0hvdXN0b24xETAPBgNVBAoM
CFNTTCBDb3JwMTowOAYDVQQDDDFTU0wuY29tIENsaWVudCBDZXJ0aWZpY2F0ZSBJbnRlcm1l
ZGlhdGUgQ0EgUlNBIFIyAhA1+mGqtme9KUZNwz/3CNvGMIIBVwYJKoZIhvcNAQkPMYIBSDCC
AUQwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIB
BTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAHBgUrDgMCGjALBglg
hkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgQwCwYJYIZI
AWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQMEAgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3
DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgGBiuBBAELATAIBgYrgQQBCwIwCAYGK4EE
AQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYGK4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQB
DgMwDQYJKoZIhvcNAQEBBQAEggGAMoPU0Oc9SSvFT+uwt3Q85Kb742vUBnJt1rQX2cFfvcqn
jmLVj8OjK3Z+sDZ+0Fu6TcEYuKRnbUXZjduMmD3dFDN961z6AjciGnrE9rWjskHyHJp3ANIf
bDjgtk2nLhJcbi9UI1XfM+RKWN22xCa2YidGba/HKwJ5p/8Gz01D1oI08Jrw663UCnhSdWJh
d7/RzIHPgBR2y6E24cZSEkJ533X5f0OFBH5pLgA6EXzR+tWek3Ec9ZkdwJffido0wO2Ug8Jz
2jnt6V+Z+jRSD9h5AYl+M3Hi+cWspTg85ZF5a2UC7DIQHC1UDMz5EzuOVnGRq+ytR7AyLRbj
v5ojN+1YQJSuGHpqzlzBR5jhA9MAvFiDYaYCaLX1vqmQL8YUhVBBYxjQJ0wHgdcuGwkHqcRO
3ekxxbsIZeUFbuoFstsZwiS9AiInMfP7NN3NAFMkcdY7ts2mKTWZmU/9qNceA+bEyJ8W/0WJ
7g9Ka2gULagsbQEPMw9tEYnuJxbmuIAHu+SPAAAAAAAA

--------------ms030102090800090909060305--
