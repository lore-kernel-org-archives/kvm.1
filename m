Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023114.outbound.protection.outlook.com [40.107.201.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4732B13A;
	Tue, 23 Jun 2026 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256138; cv=fail; b=b/C7g8VN3yxitirLfnPCdS1rW70GB/HDd3bvIKZS/X4rCOsM2D1Sc1Pbr4tQvx3ja4zOF9RZNeFLoWc2Tyu6g54lkuFIL+vM+KdLi5JAeLvhbu73LJmVqE72oXvIh7vm6CqDhudJSRZvP687MlHTPHUMmpHcnNMA9JAzw3HBA0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256138; c=relaxed/simple;
	bh=qbgE1cyuapNA48W/BftBlee3XLCbmI7ERnpiR1os9s8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gi+Gg7m7883lOkBKyb4ykoJzVE8BMRNxZcZtiJxG+LkOiQw/i++P1X7PtuWTV7948hHk27qxTuTZW/8ZesnjigBCuG6kFQ19faV6Z9N0J+eAmUDowt5idkjGIUyrOPqSjLy228HXWYwNCBdV3smmGs1l4TNWLMYvQUTEu6CUa08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=ShuMfMUl; arc=fail smtp.client-ip=40.107.201.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="ShuMfMUl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6svKZ83RPZe0hqrUq3HuMuCsa0/tWPGEF95Ls025zKRKwcNCHUzvgRmkY6ZuzNBI40lU3x1//VAGLeZH0GzI9Kt+iaylbx1UK+4XETzmhCiu35CQql9F9EVCijaY9ae9iIMZXYlnaqGxZ1z9A/winKWRrnF4sZZt6Fl/+11FyFFedfhRuDuCUaaHWz6Vp2cbqAxvgddD/p0B5wvWwwwRRRYejitB78r7xAm8zCKe1EdPF3HwsmsX4tvGcxYKGHUbAXf7WKqI3CUKp2DUjI5GZ7xStQeF9kHCIjmB/97bOHICbApRKWFBoqWuc25HH88X6MTawcrsLUE4SFDFyg8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOetI1gjjkOyKE4mM8/fPuNuvg1lHOasjTue4Z7F1N0=;
 b=JBqgy3M5PCoUC+4+PJUN31r5MPaAEDjaUI9i8DgqXwdwAb7VKojbY9I5xZZtyFCcWiZxOd3kEIUNkKAsbKWa5cIdTdgHyP850V7JMvFtYKzpnpcaPQSb0GCgZtk9wzYfQkRhXL+4RIfwxPAo1EIIzUrxE0YViUJIl4r6XealcUOaA5sAjOX+ein3nEkJ84mxj3W4s5sGXXBHVtj6cDCvPF9PA5766ap3n5qxfUv8DqSw2pbepWgAmyErkXrNY0R9Zm+fjG713XltKyBT30WlpTvAKWzYEInlPrSipVxQARzHUik56jc7wLYZysFaIrgEvfx5vXCmtSvxS1+VrJ0KCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOetI1gjjkOyKE4mM8/fPuNuvg1lHOasjTue4Z7F1N0=;
 b=ShuMfMUl2z+XdR4dU//uVn2EgeUekE+s2yHOYYD4QWPHolqyvMbgjZbMg63KXBAGPPHfCjjWTSmDkjdnAuMISoc0vrHfqeJMQA0RYhhAjb9ReD9a61Z+THPkZRsijGQZctO5OsUrTT/0vDHLs7ZCeOShkYCvaGYQsKhNlDhl/bA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 23:08:54 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80%5]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 23:08:53 +0000
Message-ID: <89c4ac3a-1462-4798-a700-2e1e9407a4f8@fortanix.com>
Date: Wed, 24 Jun 2026 01:08:46 +0200
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
References: <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
 <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
 <ajsCdRhFEw2pcIXx@google.com>
 <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com>
 <ajsO6SLATtDsXYsZ@google.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <ajsO6SLATtDsXYsZ@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070701090802060401090809"
X-ClientProxiedBy: AM0PR02CA0187.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::24) To CO6PR11MB5619.namprd11.prod.outlook.com
 (2603:10b6:5:358::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5626:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 30367fa8-5ccb-4b33-5887-08ded17c64a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	el8If54q7uDlVZaMhu0Dmv8I9BSyKIKa/aZBY9Rn1kapqpZ5vr1ifg+l/jrIB6fejKWJFIp3cZUJu0dffWBPUozGmcIBIQQzyzc8qFhIV2cK3muMjMAepcB6bTaHpo2jifgGB79Yp+X9esnbSQfqHUgl0gJrMqJKGie4K4ulQMY5Svvxqs4LmtSxDI16NvJUcj2uQrv8/viKk2w1/LW/AiyPyc+IHOpK5KT3eA0VJrujA/k/1PmuA0jHgZhUU8/4i3c/y/UpmvmMaD7NdcmSVzv0AmSRPcgSaVmRZrOOsDHx6zgrapArBsYhuUeHF97g4Q6FGbvdKsGLEbL1kkNGc03A+7kIiswbq7HkBHhQqHErxg10blEdlRKwCL5/msulqCcq1sn5+W0d057vkwBUFnc6uPUJhX/05guTq/tb+gop1WZq4GogQRcIYXEVMcAW3a/l2R5qUTQxzbYhbyZhnpgJb7kOy2D6KBGHYg2SbDafZzVwtX1c0M6u7h5Wouo8EMnWuZnPb9yKY2ViXxjezg2mGV1gI4RX4XsJDhazdQkQMl83DX7isZM2ZDHEvhpAmB29yIpu7NEN9tXJbD7zW9y3NEkzdifKfky3oR0WBczckq6xnLMDe0e8TgCR3RPwcxuIuGl72D4VdTyFvRtp39M7es9RFD78gKBYmfiWhMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZIQzJubXA3K2QxTzF6dmJNR0FHbnV2S3hGa3NLSzAyU3lUT3c3NGRBMjla?=
 =?utf-8?B?YW55cURSbFpHc1FFS3E5TzkyczVHMGY2Wkh3MDVleThTVHFmT1VwMVFCZTM3?=
 =?utf-8?B?WDB0ZytMd1BjOE5XZ0t6MkpERCtqWmVISkJmOHc3bFE0K24wQ0wvRlJZMFVx?=
 =?utf-8?B?Z0RTRXFDVTlkcVJRbkZzZ3A5RFJLK3c4UnBmaDdsdVlwcG5jRW4rcHYwTWRT?=
 =?utf-8?B?R1RuWHY5OXoxdUtZcXZVcGhCalpmaGxvMTN3VTVDUUVtcVlrNXZaVGR5UllH?=
 =?utf-8?B?L1hFNlExSzdnRi9vOEM4MlVsNm9OTHl0VWtzdE56ZnF2MlBRQ2ZkWk9JNW1X?=
 =?utf-8?B?WDZidm8rVmpibnJVTm5KditVVkR6SUZGMGdCS1hXQUhwSVpUYTJndFoyNitE?=
 =?utf-8?B?RUVHWmVDam9SVHZvTzI5RllKd2s2WklUQ2RiQnNvbjZUVHNkQnh2cGw5dEoy?=
 =?utf-8?B?RVJianZqOEtJc0JwZGFlWjlxaHBIM1pnRnVScXFob1ZmaGFoaDM5TmZ6L0tY?=
 =?utf-8?B?c2VLOXNubExWa2FPbk1nbmxSV0VwNmdPekVwa1NUR0xkQjR0YzRQMWlFYTUw?=
 =?utf-8?B?bHFCQ2Z0c01QVE5EenBLTU5wN1BNektIOGhIRXVmNks5ZFhWRDBodWpEVXJV?=
 =?utf-8?B?U2VlaGg5RzFYbTNTRTNhQ3Q1QXh0eXI1QzI1T29XWGx4cDRjZFZWR3JFMnJM?=
 =?utf-8?B?cy9JbC9JNGxyVjN6a0RmdTM3WDZZRllGV21naUdBRW5QcDhZcC9IOFB2RUNv?=
 =?utf-8?B?dkZvUURhYXY0SGcxUml5aFBqMS9laUFtbG9Sbk03WG5uNUhBd3B6L3N2eGZ3?=
 =?utf-8?B?UXd2VFlhOEJ6dGJaSTdOUzFhb1VJN0hHdEtjYzZRVTc5eVcwakRRNFBPZy95?=
 =?utf-8?B?Y2toRjkwZW16andKZXZPRWczSUhwcFZBS1lkQVY4VFRCSXpjaTNUQ01WRnZ1?=
 =?utf-8?B?N3p3SE8wWkdhek1NUGdOY2VJVXlDLzUxZ0YvSUorVlBoUGJ2UGtMcHUzYkNt?=
 =?utf-8?B?dm94MWRMSmhWY1dLU0RQSjArN3FzWStPWCtkNGxCQ3hjZ1RJMVJPUEk0VGJ6?=
 =?utf-8?B?SURST2hwUWxjUEFOTlpydFloa3k1OFY2a01yQlVDeERWdVVQTlJkc1M1Y3ZZ?=
 =?utf-8?B?QlIzQWx2YkR5WGRtd0pCRnRlR2ZxRHdJUzJWcEx5UW00VVliWFNkVjVZRTBr?=
 =?utf-8?B?UCs4V1NVYlZLOHU2aUdNOHJIZ3ZQMU5hcTNPSTZLYkFGWmt4ZHdsenpwZUYr?=
 =?utf-8?B?Ri9sYzVxemJqOUlkU25BRXNlRDk3SUNUOVg2UXNOSExnSVFCdGFpVEdjNFZE?=
 =?utf-8?B?MjJjZlVSMlJYdnRJNS9NUkdwMGs5ZWRUVmU3NkR6T1JOZXhMeGxzbG5ERlhJ?=
 =?utf-8?B?cklEYTBiV3NhV2d5WUpGcUpmcUFMZ3VqRWJjU1VIUFROdmNkUTNibWp2VTQr?=
 =?utf-8?B?bmk3UmxZREVXcHZzb2lmcGlsekNJaWZPb08rNG4vb2ZTSTQxSG5wNlpYZ3hE?=
 =?utf-8?B?QTJZWlhsdzg3Nm56ZFc2RVVQWnVSeHhOcFVEaXJkdEcrLyswQ0cweU9PK1VH?=
 =?utf-8?B?SUlZSjByWVN2YjUzQ0FCL2lJU2wvTGhobkJiM2lNNmhyZlAzTFBvUTZyeXVi?=
 =?utf-8?B?N3JTcEloeVVkakxJTlRXWFd4Q2l4aHJlQWpKa1grRFErRXh3RVd5ODdBTEdK?=
 =?utf-8?B?dkVMUll3OHdKMTByZG4wejFZSHhBVFFVNVFNdUIyU0lpV0lxb2dKY2JjWFZV?=
 =?utf-8?B?VGNsUXhONVNYWjNSMmlPc0ZIcHY0Ymg2ZjFSSlViaFNSYm1uMEtyRlpUaG1j?=
 =?utf-8?B?akNud1UzMTRmY1ZTUU0zWFBRQ3lxNVdjTjIxOVJsZUd4bXNEdUpnNjQxdFRa?=
 =?utf-8?B?bjNPcGdMWXVMcTFpRXNWdGNJdlB3ZjZOUnFzNEhkUGtKZlhDSmlOOXZMQmUr?=
 =?utf-8?B?aXFlcFd0WXdaNldBSmp5czRUdVZqeEdDRW1YUExmencvVVU0OVRtcnJheFFF?=
 =?utf-8?B?ZDdkTEluaTV5MDdDVis0SGdweGU5SWJlZzlkemFMUjQzU09pQzJkTkJpbDk5?=
 =?utf-8?B?c3FteG5ObFF5YXQzdUxPb2h5RUdmczVoMFJhMXNDQ3YzMXBGcUVSUGdFUWZO?=
 =?utf-8?B?M3dnYkdnZFN4cEQ2eURyaWNjQlFHZmdvd3VEUHkraEdEVDZHMXB5Y0JPVytS?=
 =?utf-8?B?d21PZ3lEMXh4eElRaEY3V3lIQkN6anpiTU96bXlscUwzbkR0WXJXNTFNMjZp?=
 =?utf-8?B?dEJuUjZLcktNbWxaZ1ErcUtWWGtub3hGNGluN3pyUGFxR3RNcHJLNTFRdzZZ?=
 =?utf-8?B?ZkpTSXV0Sk4weG1vckplRndTNUlRbDVIZmJldUE4dTNlaTBqZHR0UT09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30367fa8-5ccb-4b33-5887-08ded17c64a6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5619.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 23:08:53.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9S+MYsYOCOIz9bO7ug0TxTwYiGsb/nXBv4pIho4JbaIc4a5rb+FFcCqWdK6j+9VvlQ/cCLuRSsZlHx27lHTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005

--------------ms070701090802060401090809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-24 00:55, Sean Christopherson wrote:
> On Wed, Jun 24, 2026, Jethro Beekman wrote:
>> On 2026-06-24 00:02, Sean Christopherson wrote:
>>>> A UAPI that allows creation of all architecturally-valid enclaves fo=
r
>>>> purposes of measurement portability was stated as an explicit non-go=
al. As
>>>> this is the only stated purpose of this patch set, it should also no=
t be
>>>> accepted.
>>>
>>> No, the stated goals (thanks to the follow-up from Jon) are to (a) su=
pport VMSA
>>> GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and=20
>>
>> As Jon points out, the VMSA GPA is not architecturally relevant, so an=
y
>> enclave can be changed to support a BSP VMSA at 0xFFFFFFFFF000. The on=
ly
>> reason to "support VMSA GPAs other than KVM's hardcoded, arbitrary
>> 0xFFFFFFFFF000" is measurement portability.
>=20
> Well, that and hardcoding 0xFFFFFFFFF000 is bizarre and confusing, IMO.=

>=20
>>> (b) to play nice with multi-VMPL scenarios in the future.
>>
>> It's not clear to me what multi-VMPL scenario Jon is describing that r=
equires
>> custom VMSA content/address at launch time other than measurement
>> portability. It's currently completely possible for VMPL0 code to set =
the
>> VMPL of a VMSA or create a new VMSA with VMPL>0 at any GPA of their ch=
oosing.
>=20
> Sorry, I phrased that poorly.  It's not about directly playing nice wit=
h multi-VMPL
> scenarios, it's that if/when multi-VMPL support comes along, the BSP's =
VMSA for
> VMPL0 will likely be the only VMSA that is NOT in guest memory.  And so=
 supporting
> an in-guest VMSA for BSP VMPL0 would provide consistency on top of cros=
s-hypervisor
> compatilibity, and I place a lot of value on consistency.

If the goal is to get rid of the arbitrary 0xFFFFFFFFF000 GPA/put the VMS=
A in guest memory, then we just need a vcpu ioctl that lets you set the G=
PA.

--
Jethro Beekman | CTO | Fortanix

--------------ms070701090802060401090809
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
BgkqhkiG9w0BCQUxDxcNMjYwNjIzMjMwODQ2WjAvBgkqhkiG9w0BCQQxIgQg88drghgguxgI
oSffGc1KJGJRoFXQbOg6v7L5SEaCkQIwgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
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
DgMwDQYJKoZIhvcNAQEBBQAEggGAoQ/ZxTFFrMRThtCBiDj1RX1u70jLJeuoG50nNwm1l9dU
hUJHwU+cpFK1vrOu561KVmtDFPeI3CCcp49xniANbXOCe9Yg0pd8jpI6fXnGx7M341fNQDzL
hJsGihJF2fosnS2zwAGOwHKXQhzn6yPqW06RuwMeX0g1IFjfuH8HHS2krss9Qb/xLssHmlui
7S1el2KdPAPNFC85JDHYIBpgAgJtE0FHnoCvoUTNI1Nax5D/UaMgJVxRKJoBzUDQng63Qt/F
iocqOWlnqtJqaWOMWdUKzffzphT4I1Vb8RlwAfU2i2xCowKFLO1oFE9cMYxarMiVdTAWfkgA
qNwCu45rxBrp002b/Su35Yx4EYXISsxuufK2XdLBZ15qvX/AQlE+lXhbVRP9dshQdmJm21WO
ADKU7Q5AYMXKIILwI7hmlISASPoQvT69nn+jAIm6rU+CuNN30VxrRwXlmVLeROC9X0vZpppn
w70RDTZiTppeGJYWRNJMJ1d/ZJkcmDXg4QgCAAAAAAAA

--------------ms070701090802060401090809--
