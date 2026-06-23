Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021102.outbound.protection.outlook.com [52.101.52.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA553B895B;
	Tue, 23 Jun 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251259; cv=fail; b=PbDxjxUKnQzj/IiqopTBh1p4EwPGIHIEQToj2vHsrYSqulkNGiaRlm302lo2kfeUrBdeHRaQOOUaSRVWG27F3Md95feJDWJg1sY+9xBU4CuSyGsRwgeQl4pDd6WKNBWJq3t3myAczSuorBDK+XFKRaO+0kK0BkpTSl2oGPBr8Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251259; c=relaxed/simple;
	bh=QULY51cBhhXZ9vIeEVvKw5DC9AIyWaMjlch8RBLeUSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ecp7WZUWaNnMJxccLTsmyJ9alDbqBV4FEJyx4QEwAWQTFXnz5xIlLKAELhVdnEGY2kv+2Pgh2TKi73+FrZApEtRBDbaCf3EHr98weBTAXvJLMKJrTBXDDN+kYevJGfx1lSiX04iixto/h+DDdAxr0k+YSPaYsL9ClaNnfIDXqqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=StrmsMFw; arc=fail smtp.client-ip=52.101.52.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="StrmsMFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVR4YzfItNxOqaaSkHRFb5mWwqa7acVxQ7dRyWVX0yziqVnAGmMAI3LdwlXDR9XTO9ot7kMoGCDe9FJ9qesEoCIM7c77dmAs6fUejT5uXw0Q8VU+86i9b55G9+MYriLsj2pWX5XbbCV+wWo3ozrNia9RBiUpFUF+dYiWk1DPBwozFrpybCLFkl236yg4n46tM/WEl07D2snAZT0KI6ulETVIf+XN4nFtRcQwFSP/Roy27g5r8tbNtkiDtbhxKAw3QNKpcMuiq5EVOP7Ju9yBiKtTTyp0+hQh+t8jnojdjMB2GRJif4E0683Ag07tgFHcVQ/EGWVz3yk3JC3tHsfrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hb4szuFQ2+Mhv1LbMCDs63OP3EwKqh9GypLdGo0YOs=;
 b=pNse9OAg/PXay69h5bqjPFhf//Arrcomm3cnCgYNnOG241wTpP6bT6qxuq1+z8ex4w8HlVUnnAYP2Mc85VU3IpbRzKLagbBHqnp7KDk+TFPv/yarbJ0KlgZb9PW0+ZztYv94yhBtoejdvs48TcfbaqkAPDFijo5zWEgBQVEMQxZcbY1Wowh/WSavByQwIyQjzr+lor0uvvP9S7T+GS40/+HoypX9CQJuut9tYsyXJvrAijQELAonGrP3N+VbfnmceXJiqKqkkUmvSaOkvUZ1Revxn113RJ8YK1FvnTpvxOMcJBzh6zxWHqyBVirAKr8EE50wkFAOfOYFRDiP1SQs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hb4szuFQ2+Mhv1LbMCDs63OP3EwKqh9GypLdGo0YOs=;
 b=StrmsMFwHh1WpjuE9ye5wrL6O3tmvBA8z2iSNWfldHRwDtJcX3rx0XtlweHdDiyzC3H6H3WfVejLsJs7MVzcbGD7d559NsLFRrl1PNotvBLpQFJr1/KhSbvaDTw4GfmZiJ+Av8akfSn/BQZMCgKZK8hqrqNSjNrU9Q3vUyfaaHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12)
 by SA7PR11MB9595.namprd11.prod.outlook.com (2603:10b6:806:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 21:47:34 +0000
Received: from CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6]) by CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 21:47:34 +0000
Message-ID: <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
Date: Tue, 23 Jun 2026 23:47:27 +0200
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
References: <aiqwjn2DVOumfr3T@8bytes.org> <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
 <ajr-AigoW2cJY5k3@google.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <ajr-AigoW2cJY5k3@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080200080309020208000109"
X-ClientProxiedBy: AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::17) To CO6PR11MB5619.namprd11.prod.outlook.com
 (2603:10b6:5:358::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5619:EE_|SA7PR11MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: a639e34d-8e37-4ecf-cc16-08ded1710885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	LIE8LkwyImVg+jVM5xStJeMq82eNm6MMV7SFNyKoJQzNmhidzIgrM/5HYcKjwreKLT/2GOI735kbmcBxCnaiTC6G4vJRUn3Q5P1lZv38C+yjh9JDFTI9H/QUtk2V1WIF1HXkeqkXM32aSKGpAxWLDWP2UWosCnu2G8Z8i7LfjbOEGe22zpjABKHbu898HpsnnLFykUBU37bVSARW2l5wRvBlDYqwGBEaiyHyGcfCGTi5iaYtpXUOiqUHjrtPv6BmKTES1CQGloJMwsztWTBgiQuu8/R6XXbHf0aLe0dP2z0PrU0QTBYeEk5FJaeX8nIPW89DUgF2McW3DMor/tphJmmNB60vSKfQ+S9jc0Y0nvan108RBH4Ypbmj8Nwkz4kyqNX1IgIZyko09BK/PyDFOmOkaEULTKeJ3oc/zTd+4QvaLvz89BkbBaKBOBRis9xfFHktDe7+I9yUkKv4hxJnE6cjqRZVXi5jGIATV7fSwDsp5M+10R/DscPNsbPsEBEJOV+aosO1SgEfU9OYz+bA1uWvVSZaYYAYPISbVrySgn4OXXHjK3ue4NL2hulG4pCm36ewMCmgXaaL91E4A6EOW+jz377OxeBaQUrRbClHok+jE7ZOVi91ADIjtpeUXfikAErGs9s2tLpCzCe2k5gAOMX670bgWTJpwDDLauzzhp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5619.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JMa2N4TXFvTUdVNFo2dXduMCs2R25TaDBvaTZnbldjbEFOYlpCUktIa2xG?=
 =?utf-8?B?TDZtR2JQTTFmeC93dFJ5QjRLcTZVaVB2azBIdlQyMlZKUHd4TVBJQldUVGg1?=
 =?utf-8?B?QzlkUUdUZ1BlZ29NYksybUlpYTVuQ2R5SS9jQlNleU5XN0FyUnplU3I1cFI1?=
 =?utf-8?B?OEdkTGprSDJZdU9GbGxyYjJpT2VHWjhpSERBejRURGtjNndwSW1JU01WYkQz?=
 =?utf-8?B?eENZZG9panRYenFXSFpiS3p1cXlqM1FEZlZidVZ6Z1ZCNnlhVkVGKzAzZGs3?=
 =?utf-8?B?UGNiWklYNlNXczU5STZrNzQ0Q3Foa1BRMXpibnU5WEgvMUo0RS9HeXFhQ3o3?=
 =?utf-8?B?SkVtbEFwdmNCeXRrMG03NCt4a2t4Qjc4ZCtoTEl3d3NYajB2YzYyc3QrT3Ni?=
 =?utf-8?B?bHdibEx6UGFCN3IwWDBNZ29zWVZUOTdsRTNDT0QwMFNWUTJJcXJyZlR4Tkk4?=
 =?utf-8?B?OWx2WE1ENHcyeFliQXhmUHNxa0JnckhLQVUwOWR5NEhZdVFzYnRZY0J0b0tk?=
 =?utf-8?B?YjVtcVFPVjltV1JTdnc0RGpJYlVld08vd0R1b0I5bkdaSk8rNlk0M2UxYmdh?=
 =?utf-8?B?YXRlY0Z5TjJYOXhOMTkzQnJBTlVIM0RMWjBOTnNKMWN6UVNkcTRUU0ppK0wz?=
 =?utf-8?B?MjNCNnIvZ3dtOWpPUk1EMm9mSVAycXUwTmJmcFdRWVV4UkZQWkptZExxNTJz?=
 =?utf-8?B?L3AxNzBaQURXeFhFUG5aUERBeU1uT0Y3aTl2SG5Iak8yNFNSN2Z3S1BKUGFt?=
 =?utf-8?B?ZTE3NU9QSE5BSWp5SDBONEVlRm5ENFVMU0IrU3p1OXpQL2c5bldiQ1cyV3hT?=
 =?utf-8?B?Wm9OM3U5OXozL2d0NjcxODF0dWVjRzBEQmZUZjNBYlVpM2xudFBBS1UzdGFh?=
 =?utf-8?B?NnVhRDlGWWdJamlRTUJNQk5BcXhKVVBwVjdBZDhyd2RXeGthYnMvalN6M3Fx?=
 =?utf-8?B?K3hERVRhOWRPUTh2dlV2M0I1a1BiWTFIVm50SXBYWnlibTVJdFV5Q2R0Y0wz?=
 =?utf-8?B?TEN2ZVFacVRLNWR0cFdQWHh1R0laeldjVWExZVhRUjdweG1rM0lDNkViUHJX?=
 =?utf-8?B?R3c1b2NFNDZGdGN0NWxQcHR6NlNlOUc1OEhBOGV3eUtRTDl6THVBRXUrekNu?=
 =?utf-8?B?Y2pJUEtMREFpTEdoem9Eejl1UFg5L2NENDgyOXZ0VkxVOU8xN3NRNTQ5bGI0?=
 =?utf-8?B?ZG1RYXRmY3d3Uk5RL3puNjQzdDVMMkRlYWg1M1hFSGoyQ2xoSHRXOTVNejgv?=
 =?utf-8?B?dTczTGJFQ1ZtbFFUZDhjT2RiNFhVN1lxb2w3YnR5M25Hem52bThrU2lOTzZm?=
 =?utf-8?B?RUpUSU9iV0lRc0xxUk1kS0hwTkpBQzhlaGxDLzIxMlFOa0FweE1nT21EV3Ru?=
 =?utf-8?B?ZWYvTGVnVjhEdVU5Wm05NndHOGVOb2JmQ3hvN0xRRG1iNmRJUzdrU2UycjRV?=
 =?utf-8?B?U1A4QmpTb2tzd1NMSGlvNVoyZ0YvZ29waGdnOTNOOHQyNG1FNkNzOHJkSThM?=
 =?utf-8?B?Um55cDlpZUhGa1FhT2l2endVcDdnZkk3N1RybkQ3bzRnUGhmbEtySzIzMFNM?=
 =?utf-8?B?SFk4NytmTjRJUUtFbnpZL1k3WmRDZVJXRXArM0lJTk9xYnlZUm4xSnJFSVh1?=
 =?utf-8?B?ZzY1QmxDZG5ncUJ2b1hjSkp3L1RhSmxETXdkQzdZRTFCcStocDg0L2hjc3pP?=
 =?utf-8?B?Nk1vYjV6Q2ovaXZWdkZlc1RaTlNDQzhsTzdwQ1pwRWprN2pTaHFVeTNlaUJu?=
 =?utf-8?B?WDlCaXlZbmc4Z2lZZVUrNUdOaHhMQTFjVnFJOTkybThjcmk0d3lYSjI4eFBG?=
 =?utf-8?B?eFIzYW9GWnRaNzlUNmpUdjZCTVNOdnNzUHpnMkdvZ0NocFR4bDlGdklWWWtZ?=
 =?utf-8?B?N0hIRlQ1elphaFN3WFlxbXdVVDBwV1BObG8wZlNLVU9SZHhFYXRkdnlYcVJk?=
 =?utf-8?B?QmNQZThBMjVEZDk0VUhYRXBiYzVPTCtjcEplNVJMY21RbWZEZURhQVJjVkZ6?=
 =?utf-8?B?Q0lRK3BJaURtS2FRZWw5WUo3ZU9ldWdvVkJGY1ZaK2JmNGtXQjM0U0RHcGVp?=
 =?utf-8?B?M0VtSVBZMzNKMUUwYkFYV2E3WGVxRE1FQTdpMkhCSU4rY2ROTExHYzZaS1d4?=
 =?utf-8?B?aWJrWjk0MDNYd1VtNlhYc3JBYzJzRUsxdTRPQWpBTVpxalhZeHlIcVhnMW8v?=
 =?utf-8?B?R2dYZzh5RksraHNZS3lsTHZVOEM5MVd2UjdvMDV4dEVkVzVBNTlzREt0a3NJ?=
 =?utf-8?B?RFo0NHNvQzlxdEc4TVBQRml1ME9pYzFQcEpHOVFLVEFvV2ZmVjJ4VGxwa1Uz?=
 =?utf-8?B?LzU4eloxdUl6N1pFU3RBQ1JDNlpZSlMvckc2MHFqMGJlWU15MFR1QT09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a639e34d-8e37-4ecf-cc16-08ded1710885
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5619.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 21:47:34.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M41rA1w6doeMEvowlVXJRpK2TAe+gTvv/jrY1rZdkiVISOuw16VfdrGhog1/PEC194JS2MQ8EtjjgBgexzc1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9595

--------------ms080200080309020208000109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-23 23:43, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Jethro Beekman wrote:
>> On 2026-06-23 16:51, Jon Lange wrote:
>>> On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
>>>> On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
>>>>> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote=
:
>>>>>> Ok, so it took us a few times to learn our lesson.  I still don't =
see that as a
>>>>>> strong argument for new uAPI, especially not for VMSA pages.  I am=
 very firmly
>>>>>> of the opinion that letting anything but the host kernel configure=
 the VMSA is
>>>>>> beyond stupid, but unfortunately we're stuck with AP_CREATION.  Ex=
panding that
>>>>>> surface has a very, very, VERY high bar to get over.
>>>>>
>>>>> The strongest argument in my view (and the main reason we are doing=
 this) is
>>>>> actually the predictable launch measurement. On SEV-SNP this is a r=
equirement
>>>>> to use platform VM-identity features like the ID Block.
>>>>
>>>> And I'm saying that unless KVM *can't* provide a predictable launch =
measurement,
>>>> which AIUI isn't the case, then the launch measurement *must* be sta=
ble across
>>>> kernels because it's part of KVM's ABI.  So as I see it, the issue i=
sn't that
>>>> KVM is inherently unpredictable, it's that we lack tests to validate=
 a thorny,
>>>> subtle piece of KVM's ABI.
>>>
>>> Joerg is suggesting that we need a launch measurement that is stable =
not
>>> just across multiple launches on the same system, but across multiple=

>>> hypervisors.
>>
>> If this is now suddenly an acceptable argument, please also merge http=
s://lkml.org/lkml/2021/4/12/625
>=20
> No, that's not how this works.  Dave and Jarkko both have unanswered qu=
estions
> regarding the use case.  Answer their questions, and I'm confident you'=
ll get
> traction.
>=20
>  : I don't believe we necessarily *WANT* or need Linux to support "all
>  : possible ECREATE, EADD, EEXTEND, EINIT sequences".  Yet, it's what i=
s
>  : being used to justify this series without any other justification.
>  :=20
>  : It's going to be a different story if you bring me a real enclave th=
at
>  : *REALLY* wants to do this for good reasons.
>=20
> and
>=20
>  : What specifically are you referring as the "rest of the world"?
>  :=20
>  : That would be mean that there is reviewable workload "out there".
>=20
> The start of that thread is *exactly* what's playing out here.  The big=
 difference,
> and why this one's likely getting a different result, is that Jon provi=
ded a very
> thorough explanation of exactly what use case Joerg and company want to=
 support.
> The only "assumed knowledge" is why it's desirable for the measurement =
to be stable
> across hypervisors, but I'm comfortable stitching that together on my o=
wn.
>=20
> In other words, they aren't asking KVM to support every possible way/ti=
me a VMSA
> could be associated with a vCPU, they're asking to extend KVM to suppor=
t a concrete
> use case, with meaningful real world impact.  In fact, I actually think=
 this series
> is *too* narrowly focused on their use case.
>=20
> FWIW, KVM_TDX_INIT_MEM_REGION has almost the exact same ABI that SGX ha=
s: pages
> contents are measured immediately after they're added.

Sorry, the argument from Jon/Joerg is no different than the one we made y=
ears ago for SGX.

It was previously made abundantly clear that it's the kernel maintainers'=
s stance that it's sufficient to offer a UAPI that allows the creation of=
 a Linux-specific subset of enclaves with a stable measurement encompassi=
ng largely the enclave functionality available in the hardware. Or said a=
nother way: if you can take your enclave and modify it to work with Linux=
, albeit with a different measurement, that is acceptable. KVM-SNP is cur=
rently at that state: it is currently completely possible to load VMs tha=
t were designed with the current Linux VMSA in IGVM format.

A UAPI that allows creation of all architecturally-valid enclaves for pur=
poses of measurement portability was stated as an explicit non-goal. As t=
his is the only stated purpose of this patch set, it should also not be a=
ccepted.

--
Jethro Beekman | CTO | Fortanix

--------------ms080200080309020208000109
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
BgkqhkiG9w0BCQUxDxcNMjYwNjIzMjE0NzI3WjAvBgkqhkiG9w0BCQQxIgQgH0nywelbxeQr
ZI0VN+tKvbC4vXe4jc4ck2JVFxM4lPgwgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
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
DgMwDQYJKoZIhvcNAQEBBQAEggGAdH/Ylw/UL3aCc/gYcRuEcvLSKXu21pIzO5B1KQvR2zb0
wp/SrbEVMPWRbx7KRpPmRh4k8WDhl4xN3H+EM1WB8+eP2Y+Dv5SGy3T0H45eGs2+eIG4LtYi
yRFpnWlJxtYcrVgCFjlci+H4wN/NjQVo7B9WoZWbJBkNz3VdFBGqw/Dnkg/LsDlUGvsMY0y5
Q88DeNbdG691pYSYm1ACHmuHufF5qPLa9Oh13X5Is+t6vgefXildqSeH2WFrGEcLVnGOe8z9
CTjVrPtsDLKZoWcjJnUwcE7cwl461uG0jGS4DCzBOHGUaMJMTjSxjv6O+RdoexpsFNHbVl+w
hMz7TLngMGoLkJ9DrmuEwVVHH/gkVEzVM/VRyxdq5w89WnHMg3qpoyEoZM8rq4tufH1T948r
Cbz5rTrpv2rCOcc8KqFxmGhC7sDqpoZX7S7SEIfpiv/ig8GI/8FRCErUgnO4lsA09Ri/jFXB
OtBU2mVQYg4fraBxbw1Cckh3Qu+Vm3h/yBVtAAAAAAAA

--------------ms080200080309020208000109--
