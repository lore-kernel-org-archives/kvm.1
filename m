Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1533858B;
	Mon, 30 Mar 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883426; cv=fail; b=A6+XuPXWjcWc/dHlnDePlnYo2r4mf+2K5BVstz91wIJPgYBQ0DxT2t+DXvpD8X7m9CnnswD0ht7FE5g/aVEa6jFIZQFBELn55D8jrQoNdNTXAReql8/36c1Vhl0TtePRLGg4S3zwlk27b+0g0TcoWlCmhk0QFOKRfPY8isauE08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883426; c=relaxed/simple;
	bh=/yO5mVLyrrI/vwn1LSwwn+TOJejHySDhlo12qSTG5J0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EsFS3n2Zv+75+EXTPDlmYzk8pUeXaellmL9j/gbkk7OMgAl/kky9EqStMIx4wKetj7IiRhdOSX4pefrHK0v4lPOG0bONtjzJPXZ/zTKME9T/JLA14k6Tb99WjfhW0lRCv0OQiwM2y26vLp+ObtC2DJwJhzZF5kbkzAAT21x2tAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VDKmxwWc; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VDKmxwWc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3l9O/4LwaHY3c6doc4tZrymP5ep8VIzLgCyRFa+TsqHIg293dxG6kP10Lte4IHMBZfPhci1fTd3rQp7alP9TJuXW5UhkEe3dqJhcvGSdkiE3tMUvKyKsSsZJTYu1oyCirPBvT5up+hhYSkcaUnSU6UnnisCuiKQwefeOujqH9HsynZh8K59fm1i/kOmSlIluoakfsd41UV+7g+1v1F9whD4qVh+6vNaHhdMQn3OuoKzHIguriX7m0pcZ7fBFKODcd2jNrOOYc8PSrAyPoRGb9WZh5kP54BSmqe2o8tW1sFxB2RLjy7Dw9lOPS++huVulh3pt+8auf99canHmCNkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfYR6EurIpgsqx0lMu6rQuKrg04U/h1/eMZzS1Z6Lb0=;
 b=U1mOm6eY1X1WOrgw0yTyoGbdoaT0nhL/YgLqqHbR1wIaLYwD/b/C7JijQz9AdkhBi92+KzY8RvKwoH0raTBbN3I3seQf+oggGwz70EiMIKM3wG+ed0sTHp+NYECsphJiYtolMkuDaJN0verYClF9w4OIlYs+QXzE/OH1gvCOfsDGQNBLf5TpuvWKyXX0yFbkuz66yZ4MFGBmpyv/XcR51W5mEJ9HqCRWmC2PBPVdXLOgpHYdjeGB+gUzSFuUJj11Lv6/QlIFnj+scHkAyCMVT9V9oc27S+6pWrx6cv0tZJNe+hgY7pUVjXMtUIeLICmSQcCQHnLE4kir5Zkm3tfxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfYR6EurIpgsqx0lMu6rQuKrg04U/h1/eMZzS1Z6Lb0=;
 b=VDKmxwWcSyosyUovrBBv/s6ntVu5K+1L3Kvxcm4POjAEIjs+ohUx4uR0ux0rw28ezWIBG1vuwBrGWgLDA/ZS1mTlrzwwLz27N+1Iq5HsoUtWnJbLtD7LKOnyk7wipOsq0W3lsGA1kmxyqFgzGINxZuBrZx24x++GnQiu8rd0DvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:10:19 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%6]) with mapi id 15.20.9745.019; Mon, 30 Mar 2026
 15:10:18 +0000
Message-ID: <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
Date: Mon, 30 Mar 2026 11:10:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
 <tglx@kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d59810b-76ac-4984-4a6c-08de8e6e7498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fvKkXAiEB5FtHDmnq+MfgdGt+c8e3WtbL4I+FByxytlHyF0KeX8+GzB94as0KFyHE82WdsM6owOTJxMkeoJeLMzVefHILnkncfK5GVleKySbdZrYyS0PE93knwGOBDuqXmDQVdg7yv5dYKI4M0+j98zLStIqMzNIFSscX1mFMhyN7w+4qEDiODM94q6pP4kkfVUaq9XKHGX8Q8iJ0Socvr8uiWDKa+JsMTdiLUpJMWZYCcm1462ciZ7mpM696COATRwBGxJ1KxPtZLI4RsXfL+P4+R4cymFO3V3uyoVRTsmTJgjI0FPyEPV7Ys7TMaRmFVpZyEviTx5v11ydwc49PSoXN+odWv1C5OxTr9f28mB7fGxS5B0PmWC6/2NEA/D+G8HRYyKEIdhqxIo8nw9j/3bgINhDGq5AJRd3G7qUKWTtzNxeYxcWWQk9VdgiPhZT+vIrTYJRlKs72GOK83yLtpZqq+qIEssog4ZjENM+BNFdcnBJJNKGySq8nEsz+7jYWAKbG/UfunyWALryVC9POu88TrWHnD3LMjBKu334KB1UP7jMn6jIlWtGjvTDAEbkdF4yK4Bzoxejqd4MNKiQQ9qsbuYHsNP6yl3wWMBoq0PVnqz+RZtJwGQhqn2wdfnDWqrRLP/IPFAcs/9lR3M6cDElarCz8GjoEEtnphNdtAIBdg1Z4ad7WLGbmevVOigz8wfvHXVOBLDRFeVQg6MjUPx777JVcJPc8oWcCwy2Kpk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZNUko5OEp2TDkzZFdISjlxYVJHRzRQZ2ZjOGVnUHlEa2hQTXVYOXA2MWM3?=
 =?utf-8?B?blZmQ1dGV0FYSXVFM3BXUEpjdGtGemVjMHptbnZqSG9pVTA3Wm1QbkZLVFgx?=
 =?utf-8?B?WldXc2JCVzh1b0JuK3lLMmo5YUoyekpRdnFTMlQwZ1FoTFB1WitFclFmTmNX?=
 =?utf-8?B?NisvWlFyc002ZTlJdGJSMmgvTHF5RFV6bEFnSDJHVytZSzdiMFFkOC9oT0Ft?=
 =?utf-8?B?SnhXbWI5enhCQk9DMFh2RDRXS1IzelJGK1dDNFBLdTdVS2Nwb2Q0TytQNm5Q?=
 =?utf-8?B?U08vcVRQVGJMZW13Z2ZMeWFNK045WWlUQ2VDV2dPb0k2SDc1T2l0ekpxWUJR?=
 =?utf-8?B?V0krQU1SQ1lRajVrUjV1S1Zha2YxOU9acUcwa0dTa2h4WnVNN2FoaGxSTWdo?=
 =?utf-8?B?V1d2TWhsZGR5aVlhaEZTdUcrd3dhTEpFWTJTbkpiVDRJdlArVk5qYW0wZ0Q1?=
 =?utf-8?B?a2FxS1FiVmRaei9IVXFkWWxVamg0VFVzN3g0ZmlObFFGcE9kU2FlRlJDbndY?=
 =?utf-8?B?dnRMWGZXUVk3RTdpUTRWdGtqQndmcmlaclM0MXJ6cWt3Rnh6aC9mcHhkTjUw?=
 =?utf-8?B?cm9NazgrY0kxUGh6L2pZdTYzMm1zaG0wUDlqcnUrRytGZnI1RzRYWiswTVV0?=
 =?utf-8?B?N3BXTUNBd2dYVHNIMk92Yis0WkMydXNPNXJRaVdmT2QvYU1EQmhnTXlOOEZZ?=
 =?utf-8?B?cGV4Nk9WdDFNZS82TmdJNVZZNFhqVytOTDFxMUgwa1hERWR5bTFTa1F4UkE2?=
 =?utf-8?B?bFRBUWNLS0psRWdubERvM296NjVpYXh6N1J0U01uNC9JQ0JSZkh1K0ZXdTRH?=
 =?utf-8?B?VXRHM1JCeW5hYVRZN2s4UlNYeGpPcUNWd1VVZ3h5TjU3QXFUZkJFRFN6b0xQ?=
 =?utf-8?B?c21iZ2RoYWN0SlBYUWp4TDZyUHVwQ081TXl0dTQxRytIaS9SbjAwU080RnA2?=
 =?utf-8?B?Qno3N05GRFRMR1IzaHkvOWNvVFl5TWpvT05oM2JycXdvWEhOd21OWlJpbFRL?=
 =?utf-8?B?VW1PRndnb1lTUjZVTTI5OGMvN2hjZFAyRlQxVnFUYk14bWhSK3EvYjJKOXh3?=
 =?utf-8?B?MmVEamdDU0VWcTVydEtLc01KVHppZ0dxLy9CVmlQU2QybldBMldmdHprNE9M?=
 =?utf-8?B?YXkzSlpFTU5sWktrRFlLaGZ4dzU0bU54NE1sdks1VlhzVFdsM1FkMHdMRm5w?=
 =?utf-8?B?NHhwREUvUlQ5V0s3Q3k1a0lrYVNoV0hUWEs1a01WR0htalU1Mm5rVmk2QXVZ?=
 =?utf-8?B?OXpQRlJCQ2Jpdml3aVUxRUc0SGpjU2JSdFlFZTJkS2VtcnA0MmRPb2xzS284?=
 =?utf-8?B?VktqMWI5aVFRYWJweHMyYUl6ZTRyTVpSRS9FbTBxYlB3NlZIbjlMdnNrZnU3?=
 =?utf-8?B?Yks5eXVjd3dNaFpPbEVFWGtGWDZMWGJHblVuY01vWFNWc1llVEdIUmFYMUpt?=
 =?utf-8?B?SkxuNWlkMWVwQzVrRVFwTTdyVGJLV0Nmb0VCMHB5WktoOUsyRUJpS3FyRFph?=
 =?utf-8?B?MGVpTmZaajhxOVNCNlBSdkhOYUUvNWhJNUd3NVlvWVcweFFVSUt3elJDaVZF?=
 =?utf-8?B?RkZaSHdMbE9EK0Iwekxrck5BM25obXFjcVh1b2MxbURycWU2RUppOWluSjY3?=
 =?utf-8?B?RWs2Q2VCekRPS2IwaWs3UE5qbXpZVGRVMEMxa09LVC93VHExdllDclZ1RlY0?=
 =?utf-8?B?VWt0OFhocUhlRTRUcnFkOG0ycXJPT0prYzBVWEhMc2p6d1YxdHh6N3VhQ1dI?=
 =?utf-8?B?TXhJbzVlczJrTndmY2xrY2s2RTRCYWxaRlUxTEhDRG1rOXU3OXpURGZRUU5X?=
 =?utf-8?B?blBHSXh4Wks3eVc5d2wvZ3dFczNDOEZSTTQwRTNNTjBIOHZERWFnYk9rdi9T?=
 =?utf-8?B?Mllhb0dUQnF0UGVabmRhMTB0SWpCelJXdG9nRFhJNkxNVHNuVzBLS3ZxV3g3?=
 =?utf-8?B?RG5FNGdkbVFTWXl0OGtuZlFQd3k2NlR2TkRsT0hsQmdsMkFiN3ZZTE9ZdkxK?=
 =?utf-8?B?U2NJY0xYbDFaL3g3dzVWMElxMjRBUUtJbGZjRHRkSWUwSWJDdlU5SEtCRGJQ?=
 =?utf-8?B?S25rMnU2cXNXanpwaWFwZlFRNWtsVGwrZTFzeWRFdG9FSDEyZFNMbVQ3Tk5l?=
 =?utf-8?B?NVJTRjUzNExaSTdDdGdQOTdoYWpRSG5sbEVwcU1FSis0ZFk1bzAycjhPR0s3?=
 =?utf-8?B?YzA0RXhVUGFQaGd2RkwvRDdsMitNZUEvMlI5QTBENXphNDMyMUJKR1IrSGpO?=
 =?utf-8?B?eDRNQmd2MzJVQWQzNkpPNVZKYVMvRnBoWnZqT3ZyWEJwM1RhMlZFQ2Zhcng3?=
 =?utf-8?Q?X5PBApzmwwyHE/baho?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59810b-76ac-4984-4a6c-08de8e6e7498
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:10:18.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7egvQBfzBVEQoONXIBIZE/cFakz5l1sJFQlnBVIdauihfFTvG0P1JNzo6Mo/mUgUTp83sihAjj7G0tHY3L4Itw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242



On 3/26/26 4:40 PM, Edgecombe, Rick P wrote:
> Hi Paolo!
> 
> On Thu, 2026-03-26 at 19:25 +0100, Paolo Bonzini wrote:
>>> Another option could be to perform a TDG.MEM.PAGE.RELEASE TDCALL from
>>> the guest when it unplugs the memory, to put it in an unaccepted state.
>>> This would be more robust to buggy VMM behavior. But working around
>>> buggy VM behavior would need a high bar.
>>
>> Wouldn't it actually be a very low bar? Just from these two paragraphs
>> of yours, it's clear that the line between buggy and malicious is
>> fine, in fact I think userspace should not care at all about removing
>> the memory. Only the guest cares about acceptance state.
>>
>> Doing a RELEASE TDCALL seems more robust and not hard.
> 
> I mean I guess the contract is a bit fuzzy. The reason why I was thinking it was
> a host userspace bug is because the conventional bare metal behavior of
> unplugging memory should be that it is no longer accessible, right? If the guest
> could still use the unplugged memory, it could be surprising for userspace and
> the guest. Also, ideally I'd think the behavior wouldn't cover up guest bugs
> where it tried to keep using the memory. So forgetting about TDX, isn't it
> better behavior in general for unplugging memory, to actually pull it from the
> guest? Did I look at that wrong?
> 
> As for the bar to change the guest, I was first imagining it would be the size
> of the accept memory plumbing. Which was not a small effort and has had a steady
> stream of bugs to squash where the accept was missed.
> 
> But I didn't actually POC anything to check the scope so maybe that was a bit
> hasty. Should we do a POC? But considering the scope, I wonder if SNP has the
> same problem.

SNP likely has an analogous issue too.
Failing to switch states on remove will cause that RMP entry to remain
validated. A malicious hypervisor could then remap this GPA to another HPA
which would put this in the Guest-Invalid state. On re-hotplug if we ignore
errors suggested by Patch 1 (in our case that'd be PVALIDATE_FAIL_NOUPDATE
error likely), we could have two RMP entries for the same GPA and both being
validated. This is dangerous because hypervisor could swap these at will.

Would it not be better to have this information in the unaccepted bitmap which
we could explicitly query to accept/unaccept?

For ACPI hardware-style hotplug I was working with the UEFI side on a POC to
reflect SRAT hotplug windows in UEFI_UNACCEPTED_MEMORY using
EFI_MEMORY_HOT_PLUGGABLE attribute and working to modify that spec. I’m less
sure what this description for virtio-mem would look like and if it'd be
possible to do this early-boot.

Thanks,
--Pratik
