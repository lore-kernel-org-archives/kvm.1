Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8951477E3A;
	Tue, 28 Apr 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400751; cv=fail; b=nT5/BG5dxGfhA3Sx0kYB7G5A5bKdtU/qBxA05a96P6s+sWWtHPlgzd+mYP6Jw/aAYm0WhO9UML2aSSjrdVFZMxlSpf1vhq7YKRpbVBaNspTZAPcJ9lFbjAQ5PWV0KDbtnScsmjOhtgQX6PmvTog0bH9dgchwh2O7ZafrhERPwxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400751; c=relaxed/simple;
	bh=LkUVndl4hAuxkNYto3kt5EECo8RA3hTLV6oTO5XSHeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmH/dqrUm3MZMTHxXbwEHX/OL8PpOasWtDuh0YzlxrYXbs3iedHC2wVIbND6QcUYTHqdjXwWC4c5+oEIJrNSwfji0b6YqTiO/g2+odGhMp3S3xvmOJGuaJ3d7OTTbXp92hwx0DF2DUT3B0R/onR3cW3qHfO7qioQwYlPv/dXsOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wBCxff8I; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wBCxff8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCZXFPgO2kQ4WjBhkVjedAiRT7xSymDuOnb8S6fpuXUo+DvrGSiRtr4V58pWYPdne3Fy0kUW8zZedCR0ZuRTyT97CcSpdnOG/H/ZxoSdytUN4lAhSfsN5Y83lW9lWHZpTG1BgzRj2xlUv+pJI0Y8eXiPaN88tclYPj7XjzCU1byrilZsR7WYebuZ2FXM753WE8vQs31o2799IbuC/v7JwDrxxIMD1Ps9siEnTm2PxSfuwrrrNCrCtHr8/oPIHMoWhTMM9kqPQ37q5eE7s9wYi6JE6z3m+pWzvlkjbRhmVdTcYvBxomoiYwGhq+VaQDdI271rsehsSFlJhlVswWtXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FySCDsn6vSyR+I/7fac79CrlAOfL4pujWk+TIfpLW8=;
 b=DOiwo5KmE9GL+Kk8qNFNV+TacPIQ65l6AvOcC8/dooRL8TBkCSJp/lhCo5AKUoI4tS88lmMTIpuUD3qa8c8cBZkMZI3Jd4t01DeX7MFBvQZCkq5Q8cJG4pxnfuaGFAbslozad63xYdZCCXcJsRto7kuHU2En0onq4pm3Eqs2xwQzz0Q9YAFoFsvBVrrYaAQc2uEvNDTw1EUnVlMn8A+hOWGVt/DTD69r9hxslEbw9sZL/rjhgSS+/W9l6HLcaRdK0qJKuW9t8CpYTLg7BKAn2etTWI0R+wNzJpx/+dbdTKyaOBFMGRVur/6PinaQ1zQlqT/S1+Q/UaxzJWIm58CJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FySCDsn6vSyR+I/7fac79CrlAOfL4pujWk+TIfpLW8=;
 b=wBCxff8IcnH8LFICDazamw8eEPneIP9/UztgBNdPnRaf9je/0HYEdonyk3rwrHPX+oEYrVC1daO8oW41Ryto+GZ7F4mD0ljA5Sk4czLkTba9h7sqpyt6qq+38yq+xhOhBy4loA6gi7BJhkJ1gHKQvQUMg6/oMRsNSF1RRTgm38c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 18:25:47 +0000
Received: from PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923]) by PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 18:25:47 +0000
Message-ID: <23513d19-2df2-4213-b12b-8c8a9a9b9b57@amd.com>
Date: Tue, 28 Apr 2026 11:25:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] KVM: SVM: Enable Restricted Injection for an
 SEV-SNP guest
To: Joerg Rodel <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <20260424175105.4106-1-huibo.wang@amd.com>
 <6fqi2slwzxy4bwie6lqtcirdlstnh37epdl4sizfmldk4rnr66@x7s4vjhqxayp>
Content-Language: en-US
From: Melody Wang <huibo.wang@amd.com>
In-Reply-To: <6fqi2slwzxy4bwie6lqtcirdlstnh37epdl4sizfmldk4rnr66@x7s4vjhqxayp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To PH7PR12MB8106.namprd12.prod.outlook.com
 (2603:10b6:510:2ba::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8106:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: d86fc429-fde4-40d5-ebb5-08dea5539185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eL//FjMt0QwDh/MGDxFDaheuMe2GCcOFbeCo5xGWlWRFRDIafiEwB70OR5twI3ddV56rZ7L7daYvseOb4f5f4fZ+HfpJTaFTt56XmTPef/fNhW+z//tR8Rs6K6/ZnAb64pr4Lm3OZedc3sMReLi1WNoBpN9kZxEDtAXxG13rzvNLXn7G4Efd5ZPbiGyVdDC0NRV0S/lICUM+ZMktAlgtoZVrlz22VeDMo7o98Xy6tGSh5ufhEwzWqT08wH4XqLaM9Y3RkvRa/ek9SSh2N1MHHOCj0sgO1Rn33+esT/jAUJgcL6w7+cYEcuE9xyPt8rOW79VpWEUsQA1ONqlu7y4o65C6lboS2C8+qsncuhLKWlGr92Vnpmu5C9t0pbrGxHMfIAcyC73YaPv2n9iwSMuEveePPCSzM8bVZgfGOrTyhfIStHoGjp38qtuqTF9kXWv2mHWX40zozzt2DI8OMOGJkuDdkwecRb2kF6TyQtgCZwU8a9nnogWaoS/l+l45N+bnImF8dZIpsa6qXWT4wqIODEfpOnNqlRjMYcyp7q7PTERlxYcJeQnj0T69ISMKeDa3+fHhv/c90j7UgnsQbPDBm6bLteomAQNrIUHrLet9P522DVekKTBQOZNBKv5URwrpIVy0Yee4tV1ZlZvaLQ4ms8N4wKP2fTSuRchM+CyHSO/Kat/7EKdQrD4LvqcwZZvLQhvbuvbHnj+AinkRSxPhD6P8OCyb4OVqKCqcLYocwgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8106.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFNOdHJkaTVHcW83TmI2TEpmUHZKdVRtckx6M1NMMENiZU9Yc2Y5SU5rRXRs?=
 =?utf-8?B?bWZrK3F1Q2VVbU16NEhaL2xScUVQV3ZMT0tMNnJrMzYvNnlUVkQyQ1dHZy8y?=
 =?utf-8?B?T01WV1c1UHhkT0F1RjljZ3FrNjR1SGx6ZjV6dnN2aEgrR1hFREtNbm1mVmgv?=
 =?utf-8?B?b1VhZzRkNTFzQlRWYjdGMTN6U3Z1eUxHU3FYN1NoRm9TcklKRDlpbWlTZ0t1?=
 =?utf-8?B?TzlGcG90eHNyYkNiNDMwWm4wUzlETTJJZ05iUlQwVHRrWFpnaGJzbUVBc3dG?=
 =?utf-8?B?RnRZSTdRTy9wM1AyMmhBNnFFOHRTWUl3RGNGc2NoRm1ES2tSNmJZeEpQQnc0?=
 =?utf-8?B?bHQxY1hpeVJONWxTSml6QjZrRHFlV0hwUWtiaVlLZ29hVTZqaW9Zb0ZNZXBs?=
 =?utf-8?B?ZE9hMGF2ajFFbDZyc2h5V0ZSMGo5RldWcFZZSzQ4Uml6cUF3M0VvbXVHV0VG?=
 =?utf-8?B?a0ZuSENGRk9YNGs1NERVaUc4Qy85dy9tWmhzaGlTOGpjQStUTDlHb0wvdGhZ?=
 =?utf-8?B?R0ViWkNMQm1uejFoTUdjaDdFZVg0R21FL2loNUNFdlYxdUZzbExlVFBCaGhv?=
 =?utf-8?B?UVZXSjY4QnJJV3NSbnh2T1Y5WDhsVXpqVUs5ZkV3d2lvZG9HbFZnRjhsT2JE?=
 =?utf-8?B?NkY3aFlBYk1tdW9xSzF5MGNHbGxBV0tLeW5mRTRYTGZINUJ6MnNrNU92VEtR?=
 =?utf-8?B?dUxHcWdJWk91VTh0VkxGczVnT2VPRmNjaVR5ZW8zcUpERnVPa2RNQUdGMUhh?=
 =?utf-8?B?QnRKQzExaHExcE9oZFZjZjZ0ZmNhUHZtRTVuY2tkT1R2a1FORzUwZ21ZWGlh?=
 =?utf-8?B?L2k3ejEvejJPVCt4MVZkNE5PQ1lBSjdJRnh5eUFIQXZvVC9BUXlOUEd3NGhv?=
 =?utf-8?B?ZnBMZmZEN21HOEp3OGxRNkhZcWpva2xnSlowSjhnaHdTYXk5enQyYm1kQ0ho?=
 =?utf-8?B?M05VUW9mVE8vY3VmUWpLdjl4T2NCRXpSSDRTcEhHcS9LMllCeHlvWlFVMnBH?=
 =?utf-8?B?MWJ0eGhRcHptSjhTVFVWMFRTRWtIdlpyRlplZWY4N1F4TVNNTVhiR1BTNVBM?=
 =?utf-8?B?MmVpSlN6YVV2S3BOWktsYU1ZN3o2VFhXaHRJTW9ZdEcyTzVzbkhQanAvNmlD?=
 =?utf-8?B?T0dwQjZvc3dDNGRpUmVNYkZNVCtOZjZmdk1SYXpGOTdNWHIvYmxuV2hRSSti?=
 =?utf-8?B?UjRpSkdNclg2b0E4OUF4ZENQMm5ENW5lSHVkZUNoUTlYRE9OUlREdUZjRUpW?=
 =?utf-8?B?M2FTUjFSUjdTejFDNG1PWDRZYWRDZ1p4VXJON3U1TmNqSVM0WGhBNFIxckp0?=
 =?utf-8?B?M1BwMldISzY0a2N4TSs2VUtVdkZlekMvZkJicFVTVFZaMS9JTEJ6RkFLTlpr?=
 =?utf-8?B?MnAvWVNvZUhNS0prQSsvbHRQajRqUkZSVjk4RmRjaVZtdHYwaXNDd3BJVUdi?=
 =?utf-8?B?VVhud1ZpT3lSUUhSeEFwVkMyRXBHV0JVSWwwNFRHWTFvQjVuUU9PcXUxREY3?=
 =?utf-8?B?M0Z5enJ1VTFuMkhvYmhrWXlEVGVpaU5MM0tNeFVqNGFsY3NrVTJVRWxuWVJy?=
 =?utf-8?B?STVwTnJ0Nmw4SjVoUzZ2U1JMVEVtSVVvNzJYYXBxWE0zMDlERmoyRFBvSHB2?=
 =?utf-8?B?OGM2Vi9RSnNxUWxxOURaWmV5UHpZT0xoejRGOXlnY2dPWm5rUlJXNDlrdGp6?=
 =?utf-8?B?cjFmTDdjbUtSc3lGMXZTa1FLSnZwdDZtV21UREV6N0ZrMTdBOE9FWWluL09k?=
 =?utf-8?B?TDdlT1YvUkR0aUxhWm9wWWxBa3ZuZ0JCOFJ5NHN2KzE3cXFKdnBEWG13cnNz?=
 =?utf-8?B?NGxzWUdjaURybHZjenpEcTR3OTRqUHp6SUs3STJFTlB2aDVlaWRLbWtreUhW?=
 =?utf-8?B?NDFwMzFuL2pQTzhhaGYzWG5ZMk8vbW1EYnJGOG1kcE5MMWRFYmhPNkdKWmVS?=
 =?utf-8?B?Z1oreTZ1ZFRML2s4OVpyTWVHZVZyR1FDbUw3bDQxbGo4b3FhUFVuQ3dKUzFa?=
 =?utf-8?B?RjJpdmczWGdZZ1REZ240NUd5YXRJN3FZeE9PdktDa3g3SkkzOS9CS2FIM0JP?=
 =?utf-8?B?NlVGaUN6QmQ1WFZJeEFtM3ErOVVxVXAzRnd4c01RQWZxM2JkbEswdUhIZFFa?=
 =?utf-8?B?dEl3dnRnNWMyWXNNZWs1STMyRG5MNUxpKzN3V3J4RnhveTRTR3ZSL0VTamxN?=
 =?utf-8?B?alB6bW1raWpzZ202VTViWXh6Smd5bFozVUdnVlZPV1JFUjhpNGxtVVhzRHd2?=
 =?utf-8?B?OU81QWtoY1lIMmhmYklHbWlLRDNPcVB4RXA1dGhBa0pTVW81ajJPcG51VHdo?=
 =?utf-8?B?cGw3S0gwRW5JZDcyelJ0NmFEV1dKeTdtbG1zSC9zMFlrc0E3Mi9DZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86fc429-fde4-40d5-ebb5-08dea5539185
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 18:25:47.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt6xWwpuYamCHANkqOpE+x7kMwaJ13pf8zBMT0uFOy8reNZNo4+xgaUDt8MOB+8hMHOGvk7p/O2HCvBPZ/iMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244

Hi Joerg,

On 4/28/26 3:52 AM, Joerg Rodel wrote:
> On Fri, Apr 24, 2026 at 05:51:05PM +0000, Melody Wang wrote:
>> +/* enable/disable SEV-SNP Restricted Injection support */
>> +static bool sev_snp_restricted_injection_enabled = true;
>> +module_param_named(restricted_injection, sev_snp_restricted_injection_enabled, bool, 0444);
> 
> Any particular reason for a module parameter? I think it is fine to just offer
> the feature when supported by the hardware and enable it when the VMM (or the
> guest, when planes land) requests it.
> 
Yes, you are right, I will delete it now, and only if it is really 
needed I can add it back.

Thanks,
Melody
> -Joerg

-- 
Thanks,
Melody

