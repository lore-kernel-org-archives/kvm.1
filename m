Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021100.outbound.protection.outlook.com [52.101.57.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC23A7F59;
	Tue, 23 Jun 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247414; cv=fail; b=G/mUBki68gB6LliTQtb9WYvUT51WqC0paYmA0hnmiYil9xiY8qNirthIZpxLynDQsXefOQWNR7lhS0qSSoULUDJ3J124X+FJKaLaV8XUL0J6qUyVQGK4AP+doBR/9429CjglNwGpkwUv2hsdK8U12pzDnuAFU2Eey5PRj2uVJE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247414; c=relaxed/simple;
	bh=yO/Zx6VgNAX9ZY0ZHqtfAeifQpXH0zKLrNYAwvzWnPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AH/Eob2VqN3iIz0mkHB2t44O4OT30AW7FvewEfsBB4Va3PNCtvOhhU7k9r5KVx4uMvMM5sSWSXDxy/kyxlytveEzA099AbzwI0Pja2W/lJ7LohscCL8juaAH14936m6oDHzouYiy8ttNfe5rXO+6bC0iiAgqB+Pi85j+ZOl0ghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=xyNwWiYV; arc=fail smtp.client-ip=52.101.57.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="xyNwWiYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMMFHwcGKEvSw/b9Lg9J2cUIUDQPsNhEcJUMMLxhbGdFjlj2AOqdOZdzHW6IUqJKzJDm7OT9cCnb6iZ5SUJLEtU1bzX4DTaW+SzQAPuX7/mSgw7mUtipOmIJS19tN85iKRrcb2eJF4wg/P/8trj5UGut8RzOTyJAcmk3TFc1AQGfyEBjQQQ1i1Ac3faru6givQROqTadXEPOpGRSkj9uZszc7nA6jsDFGy5FkniJiI9LeFueuoaXympOH+wPRchrFtpbUiadOihooqVYpySD925Pkrv7BcA3LyhwcUx64pBObqMm/ooO9lZwFlHenyVfdMxGz2NwfiUtycvmfmVEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KldCQZVp6Nz1KkXOEXwYl6OvV/cPg0Gpae3A17Tj7vY=;
 b=ukDPGhf9uRuPpSh/sF+jQr6q8mOL9PV9nonz3jsjCyJhvPbjPJlqtjIw5M2kDtLZcVWU1qrxNmzbvYEFb69r7G2odv0sHR9JV6jFTdi21SCXo82Q0o28xcP4zokjsOTOLqnOXeSKmHf5gq/fKkpbdMcG5GjMvMi1JEGYl3fnszIjK598+6tf4SXLx3/VJHejmJP5rX7zvyyhuw/yAfOC5Ifc3i9R2MIVR1vnobm74ErL4KRIKR9epvVCb8y02BfA/ONRiHhywYau91IQGy4ARD5ZVS91PZWTPLY6b95j5u1d5C8diq/aQnRJ+YLMM00z03HO+qRXYMK2TJOfl2JRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KldCQZVp6Nz1KkXOEXwYl6OvV/cPg0Gpae3A17Tj7vY=;
 b=xyNwWiYVP6nzi/OAV4R5ieZ/ukOb4yZTdmb9BFkZHIDRdLQ9oSI2+T+dVdBl9lN7EKXVSp1RVLG2SZkzP13u5vt9bcwnkNXeeiqTnZMwNQyJ9rTPAU6xI8PST0OvcJXV1apVj1dq2Eymo1kpttFzmWUQ73R5LqW6KChQ7K1wGpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 20:43:27 +0000
Received: from CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6]) by CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:43:27 +0000
Message-ID: <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
Date: Tue, 23 Jun 2026 22:43:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support
 KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
To: Jon Lange <jlange@microsoft.com>, Sean Christopherson
 <seanjc@google.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "thomas.lendacky" <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org> <aiqtWVMqTK6vDoZ8@google.com>
 <aiqwjn2DVOumfr3T@8bytes.org> <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030901090405090302040504"
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5619:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: ab94cb92-5465-4ed0-9849-08ded1680a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	43syA34x06H/y+iBJuI52jgirWyg1czc76uIxk8VvO8wC04SdaeBBGNL8oPR4S5qf43DN6ocDz+dLY1uGSTXdjscGPfA4L+4flgsQGi0otE86Z9DUFWMG/ruw8CdCWgjbelV4C7mGMA5Ey46FAdPqR5ZOatWv2qlZ0sAGGa7fPISjZMbSYVH0P6JzNSE/NiJmkQavcNjxAAHiJRjpcC/VLrJ2cXIFJA+kESiDNdqDRqCZqPfUIm3aEj7JDaiTfpeywJ/HksLiAgfay+E0l3cEF3xQd0m5ytD4BO0NgPY8DaIu3Bhej9jhmRr/fX3uy3fz3Ou26bGmkJ3WMHInS0/nZfAorvXApsKkOQ6jxcnO8fVLmY6DL0EiF04CkIH1KACDau3XAB+noqwuD+6T5WEU7w7t4jgz6an9A26plzKDnoUZWeIcjSyQEtNfrYTgXywj6kHtj8PHDqOgDKu+H+nf+1zNiMrnHM4NZn2RRyBIxO9JX8EtVFx6XG/quJNcCQzQtamwmdbks0seHcKVc2UNjArsLpvZ9/ndyEA9sW65uAmZ7Ifw+19jwrfMXkNJmSRFsHbvnv6swxVs1z83KxdGkyOUu+/Pi/6g/QjQPnA4SmygWQoleVUiz7X5BtWQp5QJvDCfzOwY5V2d97f1A3Hv9qVChcu0NQe9IPJ9mIgOIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5619.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDZ6dWZLNm10azV4N0RLODBwUUpEMHJEZ0lIZElXK1lmTS9FeE44TVFUNE56?=
 =?utf-8?B?cGhteHdmZG5PcklzWHlMM0FPTm9VMC8zSUxrS3IzU09vZGZyQ01adEZRdXVl?=
 =?utf-8?B?MWR2Y2lsMGdXTW9Hbk9UbjV5RXpnVndIcmFkblZKRnNUZGdweG4zYUJjTVd1?=
 =?utf-8?B?d0NjNlZDTGFNSkwvSzNXbkNYMWYrSjRMZWdiR21GUTF4QkRsdGprMGoyN1Bl?=
 =?utf-8?B?dmVaa3NJdHMyS3dTcVRoUkxFdCtnZm9zVFJrNDNISDFpMnFXc3N0Zm1lWjI5?=
 =?utf-8?B?SE5LN2prbG9ybTYzNjJwV2h6eFBRbHdKNjg0M2VmNXZDa3kyZGloZjg1bDJl?=
 =?utf-8?B?SmswVjZ5ZWJtT0p6cDh1dXhidDhiOThRRkJPNFcxVXZJOUxhdVJuem9nRm0x?=
 =?utf-8?B?VERNNkdsRkxKcmZ6SzhPYUpFcFYxdDA4cGNWenRtK1FIZWhFUCtpNlRYa1Vo?=
 =?utf-8?B?L0hHOFp1NEFUV0djUDdlbUswN09GVm16eTZqWm5hT2U3aitFUE5xNFBEaDdX?=
 =?utf-8?B?SnZ4VUxyMitveUZVOXE1Sm8zRG1tVnpGWEVlZ2pNZ2QyeDhmTW1EMDdBaVNq?=
 =?utf-8?B?Rzc2T1R3aWlTcnFxRHk4clRkSnpFcGRjWnVhb0hJeTBIYWo2eitzRWRFTWkr?=
 =?utf-8?B?a2ZhOXFkUjJUeTUyV3RHUG9WS2kvRVhMbUZid2xOVzFIL1NRNzh5ZVo2UGxR?=
 =?utf-8?B?aFZzdWYzQ01nblMzaHZaU3g2Q0RyUEFiblF3cUlpejJHa3ZSS1lkUy8rVy95?=
 =?utf-8?B?aXRrU0ttSjBOc05tQzZybWxVaHI2QUlIeUxsazVuUXlPR0FNNEQrQmZxYzlH?=
 =?utf-8?B?MnhaSVhKaUVtSWIrSHpDWWFqVm9jVHdKOE9rYlhZK0dOaHVsbEFlUS9xRkFt?=
 =?utf-8?B?czJNcHk2WVlSYlFxaWNBZDY2VFZFV3RtU1pKS1RzWEhKNWVXYy9PVEYrSzAy?=
 =?utf-8?B?K1NmZGFFWTEyeWtPY0syZi81U1JFMDJYKzY3NGREQmZ2TVRtR3lUTVk5N3lF?=
 =?utf-8?B?Z1h3a01tWmF6cnJsNzJ6c2gvOFdIWTcxNm5TSUhYb1ZsckJ0KzVmOStmMHJQ?=
 =?utf-8?B?QzAxdjkxSlE4K3N6TSt1WnkrQ0l2VlRuUWxhRW14dTM4Z24wZ3ZHdjNWUkdU?=
 =?utf-8?B?UGxJRmZ6dGx1YlZxQkdtVE1Lc3E4eWtsTXNUUzBKNko1YnZCUmpqNXQzVkM5?=
 =?utf-8?B?MDdNVmx1UFJBY25nWTRZeitEdXlSdzRSaEZRbU91ZUdhcmdvN0JjNWdsdEpp?=
 =?utf-8?B?WGRCMG5pdFpCZk1NbU5ka0Y2eHZXbnBnWWRLdHRkY2lnQm9wSkduUkh6bXds?=
 =?utf-8?B?ditaNGYxbVJiNnZuKzBDdDJqMjcwL0FRS1JrUHJoUEw1T0tDMDdFdzdGTlc3?=
 =?utf-8?B?bEZ5SzZJZndjbGtpWTNkOEdhK3R6QUtBbVlXNHlLc2c0eGkvRkVNc3daNGRs?=
 =?utf-8?B?YnFlamc4emdwcG1hL1J2OFhxZ2xnLzhwbkpiUTRzODBvS0U5ZnpySEg1NTdX?=
 =?utf-8?B?dkd5Nzl2aFI5MDZETVVRNXl5UEVaaDE0WkVSWmFrdi9TZ2I0OGZwd0pvTXh4?=
 =?utf-8?B?RXh4R3BHcWVqaDRxT2NoTEdZQk91UDliSXJhL0NrTTNaUEdyR2x0YXVCNC9C?=
 =?utf-8?B?TVBzU0E4ZVVhT21HZmZ2eVA1ZkNJR2ZuZnpMZStzZGhPSWJFWTZhSzViNUp5?=
 =?utf-8?B?ZndUcmdIcUdYLzZqUzFxZUtTY2l2UjRrL0ovV1lIZFRuMzROWGluelZBbWxY?=
 =?utf-8?B?UndYY1ErQ3FSeUlvejU0S21GdmRCbXViaVFYQlpmMEE1N2doenl0NkpYbHJo?=
 =?utf-8?B?QXJGZXJYNHJpeE5nOVVTWU9lOFVSejZHcVpwZHNnZUoxRmdRMWkxbmovdlBR?=
 =?utf-8?B?cUVGd1h3MFdkdjNwLzY0RDYwbWEwNTBVajVua0FGY093aGx4VnhxWnlycWlR?=
 =?utf-8?B?NzdWWEtONTY1VVFXUzRmTUJHYndtNVVOOVBKK2RMNndZZ2d2NlErOTViY0w1?=
 =?utf-8?B?WGQrT01tekRwL3FBVC9XMFNoUVNKdkVjUG92MHNCcnZ3VldqeUk5ZXNSTjRR?=
 =?utf-8?B?YTFQdnJBMHIwRE9kajJFbm9LT2lDVVNWS1F3UitncG9mL0FSbFBnN25kWFlm?=
 =?utf-8?B?TjF6d1lQazYyMGNqb3Z0MmZqVHJNY0NvaFgvZzVqV21FOS9rUlE5dHRwNVhC?=
 =?utf-8?B?anNjdklwVXp6dWtYMG1FSFFObGx6K3gyZmk5Tk41Q1Z2MHIvQ3NhaitXcHdY?=
 =?utf-8?B?TXJuR1A5bVJNYWc3aEVXY2kwYnEvVG9FY2hSOXl6WHVoNzNkUTBmN2ZvQ2hY?=
 =?utf-8?B?ZXJBNUpJcVR2MldQWkJVWVNDc0thUUJqM3h3SFd1ekEraGp1M2VWQT09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab94cb92-5465-4ed0-9849-08ded1680a95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:43:26.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc5Jifa24zHcgzKpFSRsc4IRbaNMC27F3Ry2g7cghrLNVfmlWlk7wrI6zbORhLVkpNx9fT+dVAe3eU+C6t4HnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409

--------------ms030901090405090302040504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-23 16:51, Jon Lange wrote:
> On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
>> On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
>>> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote:
>>>> Ok, so it took us a few times to learn our lesson.  I still don't se=
e that as a
>>>> strong argument for new uAPI, especially not for VMSA pages.  I am v=
ery firmly
>>>> of the opinion that letting anything but the host kernel configure t=
he VMSA is
>>>> beyond stupid, but unfortunately we're stuck with AP_CREATION.  Expa=
nding that
>>>> surface has a very, very, VERY high bar to get over.
>>>
>>> The strongest argument in my view (and the main reason we are doing t=
his) is
>>> actually the predictable launch measurement. On SEV-SNP this is a req=
uirement
>>> to use platform VM-identity features like the ID Block.
>>
>> And I'm saying that unless KVM *can't* provide a predictable launch me=
asurement,
>> which AIUI isn't the case, then the launch measurement *must* be stabl=
e across
>> kernels because it's part of KVM's ABI.  So as I see it, the issue isn=
't that
>> KVM is inherently unpredictable, it's that we lack tests to validate a=
 thorny,
>> subtle piece of KVM's ABI.
>=20
> Joerg is suggesting that we need a launch measurement that is stable no=
t just across multiple launches on the same system, but across multiple h=
ypervisors.

If this is now suddenly an acceptable argument, please also merge https:/=
/lkml.org/lkml/2021/4/12/625

--
Jethro Beekman | CTO | Fortanix

--------------ms030901090405090302040504
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
BgkqhkiG9w0BCQUxDxcNMjYwNjIzMjA0MzAyWjAvBgkqhkiG9w0BCQQxIgQguQCh3rc3fjAO
hMl29p8NbfR0djL7RHl/s5eAmxu9ps0wgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
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
DgMwDQYJKoZIhvcNAQEBBQAEggGAVlnW00BsYQa22QaVQo5fs/FClkDXO2KKyz8cE/qiOYG1
fC4grHfki2mHLzVcor69bnwS3ImiyvyHBVbyz03dFIKkKl/6cYa7oKT8Xs1RGXQHQXpKWzko
1jv0c5gXUZNBc6nLvjrjW/nOP9HxSw4PN+YXqlFvXRGHsYKFVpsUHg1gAdvhVUOJMFClGSFc
Ij71H+nfaS6cJP0htP8DbBdFMCnRYp1DIhPKXhs1sQzHMPZ3aTv+6Z60HfUTTohgPQA4am/2
ttC6gslgekUgNZaycMhN/duMPWYT9OsG9cNJj8m+DSGvSU6xnb10VPrD0aRNgowoaAFy52/K
E6OC9R/I5Wap5Xl/y7/aEComcnDtOFR1cD+fx9kgOckk/A1/vd/KU7IaPDVXy5n4BVDd38yW
fpoE882GTYA96vbxuQgaizFQ14Arx9CkJoMU3I5YA58rmgKsA0FoFgbumg6UD7pHw0m72FB9
kGMOfdKl9UJkdu8WMThdJEj+ShJkEl9QdC3OAAAAAAAA

--------------ms030901090405090302040504--
