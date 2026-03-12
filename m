Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013051.outbound.protection.outlook.com [40.107.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2B351C39;
	Thu, 12 Mar 2026 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340440; cv=fail; b=FcjN74IQ8lzH8B503Fe9Hjp8kpunia4Kb4bhrREhrN84wJFs0h4H+xOLdWvb5qU3c7a029l5/GmQSwJ6Dj0iEvQTyDcYv5XLt3gqR12QEDVFDrNO7bV6O+RisRM7Ly3Mhb7deX27xbFI672hqUvkH0KCRlY5+7dqhxPB2V5KZS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340440; c=relaxed/simple;
	bh=EpkQBNU3tc64ltBp+wYkP+EgvuX0fUEz8uAbpxMcLB4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ITgBhMTr6n+NZiC1rxND/BLKPdISu0bHU1KeXHNsv3/eWUCYSsl9/IisCzFRqF+xBmXFLg6rRCuaLlZSkx/7G9kET9FusBew1MM3TIg5b9WyYmHoRRr9hxwlWyX07r8W+OrBtgejRWjhVL6/30SRLnkR2bGXxALGt98DEpRhH78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=TUdNmUln; arc=fail smtp.client-ip=40.107.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="TUdNmUln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt+tg9J5W5o+P56KzxoBAUWbvdM9V/OWymxxG1ocP1jpZUgyYXukcjySN0c0W/zgy+1bcDx90gkn/qXq3okUFUQWRsNcHsB5j9oGF+gsoyHtBGcYF2Lum+WCDXm7QjbeARc7UGnOvOqt0a0hACwnrsiks+zu3zKX8Bzk4hnVkGVulfrDKXQbIQMRwDQ1kOIs98teJH72a0dcWQsaufowhDLcYZgf3DflC05oNzqci5T5zpCLZJztK2UGOcIpmLZfvKJAkjIINGSAe1S8fYFrzy75My7y7dAJWzC48EP0LDEl4w3/s1TCJL4yY13s/kldxihjpUKZcxIQcM/JykPdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TGBqYDq2jTsmbnFrH+zWwRIxoBKMHRf/iuzj2Cp6A0=;
 b=d686H6XxJZUZkdCqHaVjNsW5O8r54z0n8yQdZ0ayLIu1q7UHbWXrG13FgscwMF5jsTbE7tmS1TGNUlRacwTLo2jnAAresFBCHsmYOxOPiS707gUC7U3vwPuLNKB+erxADbvdKbDXNqsWQ3vJxVelSyqXlkIjajzTyxAOBHlOV8JpT40tDz9hez454yuQep0EP3Ca70m4XizN1zQIw94XDhKsMY+0atso6LjLektSnUNoEiyNQb/Zio19FL6m+iXRaL34huiGK1wgFpZ3JWY9d75hjuL9xSNgYBP5yNvqwkGco8RoQ5TbyhmIkw9+2ZJ9Bkb79hvd4vkLUSLzNkpCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TGBqYDq2jTsmbnFrH+zWwRIxoBKMHRf/iuzj2Cp6A0=;
 b=TUdNmUln2FC8VmFZ3CjQZTRPIIGXkojWAITLG0bvH8WoP6GbUyC7s5wZYyQiGM10T5DzIFpgNDt/M/ztKRlFO+wx3AwVtUXphLIiwlu5+zGlEzOvZNvCesC2sLgcJKykZuKUrEUpYzjM1ZeQltks2FEXxsAJfdTxy/TSKSWdZNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SJ2PR03MB7138.namprd03.prod.outlook.com (2603:10b6:a03:4fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 18:33:55 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 18:33:54 +0000
Message-ID: <0d421d90-654f-46ef-80c6-1f6674646a30@citrix.com>
Date: Thu, 12 Mar 2026 18:33:51 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, chang.seok.bae@intel.com,
 kas@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, x86@kernel.org
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
References: <abL8SW5JS1aV5goa@google.com>
 <e76107e3-b93a-4154-859f-d22de0ee6f78@citrix.com>
 <abMGHGMTfz-qaPxI@google.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <abMGHGMTfz-qaPxI@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0248.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::19) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SJ2PR03MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a81460-e9a6-4d91-896d-08de8065ea66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aswY0v6xsQJIl+ociWsqMPTn2caVXbVJAnszsehS6IWFMirsOUSl0TXKReOXX6GpbMdQZ5igFfTDKTix+Aq7NPO6HHu95MaiwLKCHLphT5WR/JQJ6yknLuOSNnPjWvWEcATg70pDP2Cf76fxsWkSIwPJCaE+YSVWBMI4n14VtYUYdg+9i13R0WlJ0oBczv2Yl7a1/IBwE7sEOMSvJyV7Kn0Cv0AuuCTXIi0a7McTTVZihmGatye+RSO/tiSvcTaeGIRbvRNHIet8/05l3kji5RLehY+GRh9HoepXOdkw4R76eaPfemTSCldAUvDx+P/46MRNgxsl3wCvM2YJx+HqnwEYUovQcw+bHeuerqOHJy0Xnvj1uBFRKf+Xx/dtOL4nvY3s/JGEi++jrIy5il5dFP+3b2Seae4SWwoouaTQXFSHtZpziegNcFgKc2GJw2nX/s4HDY6KoEcWqiRRNU1Fe5cHfsaFxstprEEEPfzVyr5SBK2ep9zGDTUxuXvxjl56JQr9AgvG2UaXZPqsZcOBou2cFCDDG6MkqAmmPB8x/9k8v5w9vb9mzwvAzgI+XT/7Ndpwb1OeLqFIeDUJCnrGzaW4GdtXVpUsU61yrhHHCXXS7BxLPUfbECW5eP5kL6UG0BxB09yQTv7honk31UXcTXOhSd2wxb4WoITZOZPnpZSOB3M9KgfWyPtYxtGPH/yPNn76s8JCubyBnyrrnKMTudTEjfl9DHzqwwvCj1NbjJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC9IUXRRc3FDbE1ZRnJsOHRhdHZNWm9BaEh4TXZpeFBiT2NYMHArWWgxQ0ho?=
 =?utf-8?B?MThpNUIxam5pcENYdVY4ajBkQjE0MnZZMVZiR3pGMXMrTkFsZXF2dWVTWWpK?=
 =?utf-8?B?Wmxuak5PYW9idk9MRTBHVDVyWTE3VnFpanZiZ1F0NlQ2RldBMTNtTjY5RVdJ?=
 =?utf-8?B?b0tiaTVnOWRpamNKaWZnR0hSNE43V2FQVFNNWTRlWGZ1U0FLSCtQbUZwSGJk?=
 =?utf-8?B?MFNXc0gwMkw3MTlOZitxa2swcG42VHBnM1RmNFlrblZCRkFyZGFFZ3UrMXFP?=
 =?utf-8?B?c3NqYmZ3U3Vtd0Zodlp4MVlwYVFreXZ6LzRoaUcrTDZwYkd5WE96WDJLcllJ?=
 =?utf-8?B?ZnNQVWtXS01iVVA2NVZGU21qQVI5cis3QVk2QWFLRkdBZ1pkVnpLMHh4OFoy?=
 =?utf-8?B?UFJ6OG4xNVBodjR5MHF2RC82OURiYjFsVGcycDdQNHdxdTVqWVB0Z2p5Vkw4?=
 =?utf-8?B?NDVHNkxzTkY5dEtaeHlidHRDK0lxT3FYcXpXRmo3K1c2OHN1VVVKMytiVlV5?=
 =?utf-8?B?blN3TFdxb3dTMjNIMHZ2aXN5NXd6Y2NNRmQ2VjRwUGVERFdUbEp3NlkxZ0VD?=
 =?utf-8?B?dlhkbWlZcGZUNHVvUmZpVm83TVBsdEFtYzRDeFF4ZUszeVRKWVMzN29UbitY?=
 =?utf-8?B?QVJ0SGtUS1FEMS9hRVpJY0VlVEtzQWZBR0xYbkpCMTdvaHZDQ0MvY3JRVGl5?=
 =?utf-8?B?aCsyOEJXNWR4a2w5anFzNUdhcm9ZOWhONk9KV0Q1NlcrNEpqWnN0c2FlbjdZ?=
 =?utf-8?B?czFWL1o2SHJUOGJjRDgrUlpzSkkzNHI4ekdYa0dOWVpacVJDYzNzME0zZ25p?=
 =?utf-8?B?R0liKzEwbmkrazdHaEFsTlhiYWtGejVVeE5vTWZ4a212M1FrK1ByZEZKYjB5?=
 =?utf-8?B?NENPOWVFK2RpWEtVQ1IzbndmRzI5ZXhwVHFHQkJmMFZxQ2RVdmw1bmxkUkdm?=
 =?utf-8?B?b3B5K0NocDJRMUMwRWlRZGZtOVc2UUJFWDNrL0o4OXF6ZVhOWWVPZGRSSml0?=
 =?utf-8?B?enl4bHREQVlUNnFLeUg0MSs2NFRJb0VEUWxzbzZUbFZERFByUVRQTG5nUzZ6?=
 =?utf-8?B?cGFrZ2htOUl6SzcvUjhZSmlKSFJabURJdngvYnVyZHBQa2d6N0V3aUt1NkRF?=
 =?utf-8?B?RG1RanFLSGE4Y2hkTTRyWVdubDRhdkhDWDYyOE9JRWI0ZWlpUTd0clJReDJD?=
 =?utf-8?B?eHl3NGpNRjNYYjYxWUlPNm5BeGprMFhYcjNSdk4yV0YyK1FhTFQ0VHpKUFJQ?=
 =?utf-8?B?YmVSZVY0R0Z1NE9pRmppdGpjNk1IK21hNlg5eU43MUFOKzNlbE9SNVgyVDA3?=
 =?utf-8?B?YkFjdStsTjhTK2hQemNGbU1rNjcxSHh3bnp4ZmY2S1hvSXdJVG44TXRHT3VF?=
 =?utf-8?B?N0V0aVNDZFJzQytTMDBOVlN2eXh4T2dyajdoYTExZjVFOGpPZlBRNmFMNzYx?=
 =?utf-8?B?WEJRVFVRejVLR0dJZW4yN3NhTXJ1T2J5dHJ0elovUXgrbDFHVEdqbHA3NjhC?=
 =?utf-8?B?TkV3RVJONU11YnVlRk8wM1BOZGJwOGRpcHlBWmduSUlLd25XblpRN1UwQVlH?=
 =?utf-8?B?eElkeHRSdWJrNGl2MnpJZVZHUEx5WExlWGdKcW1Zb1lvRlBsdUxXSjJvZVFD?=
 =?utf-8?B?M2Rob0ZoMjU5TjlTOERHc0d1bjNJMVg5Sm4wUDI0V2ZzMzNBejFjTHMxb3py?=
 =?utf-8?B?WHNoWDNTZkNJOVptNStOUnF2R1U3cVgwaHI2RWQydmJBVE5tSFlrdG9VVEJy?=
 =?utf-8?B?NHBIdjIrOU9nczVVSWhMdWtYMzdrZmJJZHJ4YytDVVR1UHR1RUV6ZGU5NGky?=
 =?utf-8?B?VDFXOHFGaVVJcVREbzNzM05IZmtSQlVWZlBjeHdYL0MrK3RpTnJvcHUrckdY?=
 =?utf-8?B?TmtCZ2VkM0dNdFNldVhxWE1sNy9TZnprOEMrOFdGc29YbjFlSFg0ZExXbzBK?=
 =?utf-8?B?VXdRT0dyUGUwdUtxQVk4RXZlLzBJU2t4YTUybWRodnIySW13K2VndkZYRVZs?=
 =?utf-8?B?WUNVVlN4UTVkRWVWRDVsNHpCSWZ6N0NNWCtmd2xZSkp3VUM3SFlSNmNEOVR4?=
 =?utf-8?B?WDJFZWc4eFVrWDNpeEdGcjFzSG9rNmI5RkJTQ0w1WDZCdmdSQ0dDWXhhSW9N?=
 =?utf-8?B?bE1uekFLR051NWRTQjNyY1Q1ZlhmOGJxd2JIbmJTeFBaTzdvb2xHczJ5MUNx?=
 =?utf-8?B?WTE5VjBPRk1naDd4b1ZhWmRXRFJ0alYzT1FJcHhpODVHa2lJejlSWlhGa3F3?=
 =?utf-8?B?RWxHeHRSd25yQlhDSElnT01KT2dWb0VUNmxwOWxxV2tjaHkyeVFkMmVTS2VJ?=
 =?utf-8?B?bURMaXFGTG8yK25aNFc2cVFZVEowaFB4a0xWNGpNY2VnY2xnOUk2ZEhIdStR?=
 =?utf-8?Q?L9If0iQHfj9p9nRk=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a81460-e9a6-4d91-896d-08de8065ea66
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:33:54.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz5xYE+d3tkgGXgR7gEo2kTBMEgmNByrUna/zodZoWqzXahZUbTmddXgSIA6MYXm/U4pNWeNmNswDcYS6B15ZnF6PczwlbGIzjv2HVvsqLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7138

On 12/03/2026 6:29 pm, Sean Christopherson wrote:
> On Thu, Mar 12, 2026, Andrew Cooper wrote:
>>> Have you measured performance/latency overhead if KVM goes straight to context
>>> switching R16-R31 at entry/exit?  With PUSH2/POP2, it's "only" 8 more instructions
>>> on each side.
>>>
>>> If the overhead is in the noise, I'd be very strongly inclined to say KVM should
>>> swap at entry/exit regardless of kernel behavior so that we don't have to special
>>> case accesses on the back end.
>> I tried raising this point at plumbers but I don't think it came through
>> well.
>>
>> You can't unconditionally use PUSH2/POP2 in the VMExit, because at that
>> point in time it's the guest's XCR0 in context.  If the guest has APX
>> disabled, PUSH2 in the VMExit path will #UD.
> Oh good gravy, so that's what the spec means by "inherited XCR0-sensitivity".
>
>> You either need two VMExit handlers, one APX and one non-APX and choose
>> based on the guest XCR0 value, or you need a branch prior to regaining
>> speculative safety, or you need to save/restore XCR0 as the first
>> action.  It's horrible any way you look at it.
> Yeah, no kidding.  And now that KVM loads host XCR0 outside of the fastpath,
> moving it back in just to load APX registers and take on all that complexity
> makes zero sense.
>
>> I've asked both Intel and AMD for changes to VT-x/SVM to have a proper
>> host/guest split of XCR0 which hardware manages on entry/exit.  It's the
>> only viable option in my opinion, but it's still an unknown period of
>> time away and not going to exist in the first APX-capable hardware.
> +1, especially hardware already swaps XCR0 for SEV-ES+ guests.
>
> Thanks Andy!

To be clear, I've got tumbleweeds from one, and "oh yeah, we'll think
about that" from the other.  Some extra requests for this would not go
amiss.

~Andrew
