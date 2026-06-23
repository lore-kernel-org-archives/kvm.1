Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020143.outbound.protection.outlook.com [52.101.201.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC35269D18;
	Tue, 23 Jun 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254151; cv=fail; b=Xy+YcfhNuHFmrEHb1TBKvaMZVtqupP0TGyHVL67tiwSQT6db1/3PzdSbVwMYL/bjBVPgzHzNhbTy8hGnvK8BZ9CpzRVZf4b+/wxXCEgyFTJNrzzse904ipz0x/PTLa49nBUDn/SfsCLF3gUh4/6shTEIPLw5yX/7LQGQkXHz70w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254151; c=relaxed/simple;
	bh=VaZnvdl6pdRpbVNX9ZRsSeDKKVDeu0OOijNfYVsLEj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D29pY7UKrJQH07kalFjb/Q8CxuN+fW3GmyKEznK4dviikr6aj3JpoikVXdybxIsQN32M2DnaeBv/ulSvWaWbCkN8iz1ophxzhIkf70KzL0UB3ESf8L9Yu2iZMDp117pos70PCtu0MZpMKJtAN+ON4uNSaSjbLzPvye3jAZtrYNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=xL0bguAb; arc=fail smtp.client-ip=52.101.201.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="xL0bguAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuJ9vWp0yN9pSwvNx5JJ0jdHZHQqrDVPRk7Ujr7Pwir7iJs4MnTAHv9u8vIS6DWwshXJI7K2FB3B8k/mdeuShj9CJ16MqTyq3OojIiVuCCDfS16j/6ew8vAlZTNFlNrCxkr6mCTGjq7+9igDyZv15cSN5dTn8Q/tCkwSkmCbkOU0E5sLcQ0L2ZrPoO3Z3lld2opmqoFpf7M+xJQyfphzowCNCFYmU0+8uN4eORo9jFPxlfj44kRhzqPRhGMEsdqrfnRXKxNmQpH8v/iW/17Qg1LipBLKSsLie7kY/XBTXyeFtLMVafFBrAxWGVGi/zkskoOEXKvUAaLhBWeHRZuMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSIMnh4bKJEk2QSXcvBK65DiEPHLkTR9ZOG5j+srpWo=;
 b=ONTMZfP7NIC1RstFVapGfoKK7lZVRCZJ0P5PHF1/XDgCgIvbofLrcKV3ql3zOzTArDu/1J0nHfa6/Ql7+XZhIoKFck9UmspJpBHOkXDAGJvjuaKV0Iah+RF+LL/uDLYcldeiVW6g4unqbDrMSz37L7tCkRMFoGXlLaWs3FE6WAazZmffWEyOi0omONA3+USMlQ/mzLa9/nBRezw8GiMSbQP+O9IwbGgDd1igjI4+4ZGntj/8uEDBQampRX8qABE8n7ySLDVgTCXeIdwj5rMOFYq0mfHbOv1mvQZe6lcOfbsdS7GC2V+lypeBW5DgGfqUftFNMpJtbm3T8dsiLzRFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSIMnh4bKJEk2QSXcvBK65DiEPHLkTR9ZOG5j+srpWo=;
 b=xL0bguAb4J2P7oid4VxThQEeyv4B5MO3rgRB1UOmxWxnth9LtM/SgqzgZy4yjwL1XUsShLIhRIPT7YnqT3FTiCClezBSz7ZAL/IOKpKzSJ9//L2mgy0CDDDmfgBuxUUUvqzQiJQ/tQv37xTdpnAWzTkpM9I9IHjKZoUUqtQwsFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 22:35:45 +0000
Received: from CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6]) by CO6PR11MB5619.namprd11.prod.outlook.com
 ([fe80::729c:2dc:b1a5:ff6%3]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 22:35:45 +0000
Message-ID: <4982d413-4634-40b2-a9f6-566733933c2b@fortanix.com>
Date: Wed, 24 Jun 2026 00:35:39 +0200
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
References: <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
 <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
 <ajsCdRhFEw2pcIXx@google.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <ajsCdRhFEw2pcIXx@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030903040004060902040409"
X-ClientProxiedBy: AM8P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::16) To CO6PR11MB5619.namprd11.prod.outlook.com
 (2603:10b6:5:358::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5619:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bb903a-546b-484a-d1bd-08ded177c403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|5023799004|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	+SwIMcqAkG2CIOxRW5jqKNuHUS6BaLlZpPGeKcI/spIDUE6xd1x7xAjApD58jLac3XPprt0M1U2BQnhRgsa2+pVjeF9HHCY1D9HfRup3sHuLx/F165DG+3xLf7oVicHmSqgDhfhIwPyKatF5MdAX8YJlMVSE1/hWc0mK8R6fOzIVGQp/xLZGtl6ZSNp5Dv97L0XzyRqWJDkldQbCIweInJedZMz0DlMlyjEtE9ST3KVelb0PDJrbeXy+dv3pxq/VWa45pJYbR+RYES180EOyGCS1t7tdfJnA2qPvdryxPn++a3y4T1AolrMkPgGd6gTuDb18VAGNmCz0cuMxOZsSUTfQzMRlvTL2V6FSu1oQR2ocFolTAPDltTgReDCFIR9UgNZSktMeiY3QJcunLfT46teIaEEa/9twyETXI9O+tgFnHIm+G2K2mGAs2nMRBZwD9fcgK9yHfv1i/WURKBaRUio5DBT0Itpj0+fZLPft6FHPMGzORnkO5lS1plk3CDUOwml2OavXt6NWtWAyjvTT3aIV67dCPEtSRNyKeKSzI2uSYstwLARwyvW5tAQvNsZ+moViOc8kb7tF7rIQ0EDZ0Qe1vBp1D9c2Pai77prPGPa0cE7BwWwRk3nzNFA0yvS49GJj3iZMrvx8IbbdNlGEfYnrICYKMGyBpNYoggiy674=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5619.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnJidmpoT2lVZ25pVzVaVmRXeDRxYlB4SllFU0JVRFZaQWl1cjZxVnhXY2Nn?=
 =?utf-8?B?VWpySDdpeDI5M1pPSHozRFhITVM1S3AxRlVwOFlxak0ra3VIMC9yMHVPc05r?=
 =?utf-8?B?a3pMMno4b2UrMXV2cnZXVERLdS9tT0xLWU9LOFdJeEY4VGRIdTJPaDlqVi9z?=
 =?utf-8?B?aXlwVDNTVVMxZzdXUXdZWkp2c0szZ2dOMnVvNVBRNmRuNW04U0EzbE9zYXlr?=
 =?utf-8?B?RThyS0hsYVhlOXpDMXppNGFrTFVBVFg1VFlEaEY3VENhS01BU1BlTUxJZndp?=
 =?utf-8?B?cnIrd3FLQUQ3dlgydlY0Z2xiNlRsVlcrK0NyMXB5b2pCSGdIQjhUeG9EdjRD?=
 =?utf-8?B?M2NxQ0xLckFyS3NheUE2UFJYSSs1L2Z5aFZKQWVGdU9Qa0F3OHc4SEtra09M?=
 =?utf-8?B?ZjBTY0lPTERkMGZtNWFIN2dtc1U0aUcwU2lZdE1sMG9xZEgvZ2FSbzZqbjhH?=
 =?utf-8?B?VnhQeE9jOEN4eXIrNllQaFN1aWIwdjVJYnk1UzhvQWM3WHBqbTNFNVdxb3Ft?=
 =?utf-8?B?YXo3bnpUdFdJTWg5bVV2TkMvSmozRE8vT3h1RmVRMi80Q053WmltNExVL3hk?=
 =?utf-8?B?cGNHNkY5bmx4RkJxOXRGc1ZzRWJDQjVQcC9qVUZ3UFJDa2FEdFk0SlQxWjlk?=
 =?utf-8?B?QVlrL04wd1ZkaHpmQ1ZwTXVyc2xndVZoK0lBRVM2MnhQcW5uMEs4VnpSQ3dv?=
 =?utf-8?B?TllkSDBwYWpkT1hST292V3ZjcjFKUWEveENMVzNjTlZ2dFFMUzRjYUwrZE1o?=
 =?utf-8?B?RFlYdk9rRlRzMjh1VldIalVOVTlOdlBXamRDL1JSd0t0MXJYdklXSE9RbVRP?=
 =?utf-8?B?ekNOQ0VPVHFrdmtYZTF1a0tpa1pvOHFuclNzYmtCUW9nSTBTdHlmbUo0UG1r?=
 =?utf-8?B?ZkhZS2FkRTlQdHZsM1dXWkErWi92aEJkSU9hV3RxdWZlb0M0bjlvd1Y0UXJR?=
 =?utf-8?B?dDg0UWNmWEJUaEx6UVQwc2ZTWFVSSW9xaldVaGVKNDZ6ZkhIVy9KOXBFekJt?=
 =?utf-8?B?VnNBV09yVGJhSUt1OEliMTB3NGtNYkJqWnlSaEJDN29TUEE4VUxUYUE5d2dR?=
 =?utf-8?B?ZzZOYmx4UWVuQzM4cTJzRmVhWXNtbGdyUEY3bk5iRUlIWXUyUlo2b253Wnph?=
 =?utf-8?B?Y2pVNStkemwvL2k1eXJrMTZiM0Z5bVlXWXFOb3FzcVh1UTNJLzRlZC80U2JB?=
 =?utf-8?B?UHVqOHBXa244QmhyZmZ6Zm9DVys4cHhZMUE3bDhPemVrRGNZQkVwbjJ2OUpR?=
 =?utf-8?B?Yk91c3ZONmwvQzBtc2V6bkEvUGpVQ3VjWnNZL2RFUlNHb2NNU3daM1NGMHla?=
 =?utf-8?B?N0Y0K2w5V3V2bVc0SWtVd1pKOGowMXVhOE9XanZjZER5djhnbGRCTEIzeXFh?=
 =?utf-8?B?SmVKU3FoaTc5bnBldFM4MHVBTTl3dGZuc0Jzb0w5K0RnUkZiYVB2RDJkL3Vs?=
 =?utf-8?B?aWl5YWdkazYvTjFmRnBuN3FhcVdIQXVLZ0V5SVRZZkpYL1JDNTlBYk1pbU81?=
 =?utf-8?B?aE4ycFArLzFCbGJRNHZiOHpkczNWK0FCdklMakh6VGhYenJGM3ZWYzJCTytB?=
 =?utf-8?B?ZEwxV0w0dWJQeVU5bUh4cmN0YlNsQjhrQ28yYmhKY2FUZithWWFHT2syRG9x?=
 =?utf-8?B?UFg0TDFRTlZkekZ6SnFVclhRUXk0b0NQRnlRWmtqRjlncVJQUGJJWll5R09O?=
 =?utf-8?B?T0ptMHZObFlOSGZyRitBQW9QcUxsMDlzSmE5OVdScUxCeW5aL3d1LzZNNkFn?=
 =?utf-8?B?a1A1WjBSTkJ3aVBVdUpRNWhFcEpMZ25VWmlTZjRBWlRRbWZKSWY2WHJHaVNh?=
 =?utf-8?B?NzA0R245QUc1K2grbEY3VE5GT0lKZFdwTHlNNGlRNjdJNU5WdVh0d3VFK2xn?=
 =?utf-8?B?N1NKTTdQWGFnNVd5RklBRlYwYU1WL0hiN2pReTAzM0kxUm8zTE5NMlpwUElt?=
 =?utf-8?B?MmRDRjc4c1cwK29wanhOdEErcHdqWlZ0azF4UEczallaUU0wbC9UYU1iWnJp?=
 =?utf-8?B?RURFbmtBcS9ZTTdmZm4vWFJRM1RyakxqRlRNZ2NKWU11NEZoVml3MEZEVEs1?=
 =?utf-8?B?SElrQzBGSmIxRU9xSm1BTk5IYnJFMVV6S0NQTFhFbVN4U3pqdHN6ZWxFV3JR?=
 =?utf-8?B?cmFmWGdzN1JCOUphY21GZ3ZCSHhURFUzbnhQeHVQbGxFY0NZWEp2SjRTVmRr?=
 =?utf-8?B?TFZnUjFRK1lvSDMveGhBQ3puQlJxREJJSnY0R2UweFVrOXQrNy9lcG4yTGJy?=
 =?utf-8?B?R0FrU0haYmFsVjZHT29LaStnQ3lKSHFlYWFkMTQ1NWhSOFdlY0ZMY2drS0pK?=
 =?utf-8?B?aFVZeW5qOFhuUFlKWCtuMDJOSGpmSWJaVmtaZlNDL2EzY1M3OWt0Zz09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bb903a-546b-484a-d1bd-08ded177c403
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5619.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:35:45.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iIh63IRm/3Nd8xT1UoxBUjXdVQYpMWe6teNBdSPsUxbg5WaPqWuWbssU4K2ZmsutsHGRmeWaq7DAjtWZ/x5LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077

--------------ms030903040004060902040409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-24 00:02, Sean Christopherson wrote:
> On Tue, Jun 23, 2026, Jethro Beekman wrote:
>> On 2026-06-23 23:43, Sean Christopherson wrote:
>>> On Tue, Jun 23, 2026, Jethro Beekman wrote:
>>>> On 2026-06-23 16:51, Jon Lange wrote:
>>>>> On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
>>>>>> On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
>>>>>>> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wro=
te:
>>>>>>>> Ok, so it took us a few times to learn our lesson.  I still don'=
t see that as a
>>>>>>>> strong argument for new uAPI, especially not for VMSA pages.  I =
am very firmly
>>>>>>>> of the opinion that letting anything but the host kernel configu=
re the VMSA is
>>>>>>>> beyond stupid, but unfortunately we're stuck with AP_CREATION.  =
Expanding that
>>>>>>>> surface has a very, very, VERY high bar to get over.
>>>>>>>
>>>>>>> The strongest argument in my view (and the main reason we are doi=
ng this) is
>>>>>>> actually the predictable launch measurement. On SEV-SNP this is a=
 requirement
>>>>>>> to use platform VM-identity features like the ID Block.
>>>>>>
>>>>>> And I'm saying that unless KVM *can't* provide a predictable launc=
h measurement,
>>>>>> which AIUI isn't the case, then the launch measurement *must* be s=
table across
>>>>>> kernels because it's part of KVM's ABI.  So as I see it, the issue=
 isn't that
>>>>>> KVM is inherently unpredictable, it's that we lack tests to valida=
te a thorny,
>>>>>> subtle piece of KVM's ABI.
>>>>>
>>>>> Joerg is suggesting that we need a launch measurement that is stabl=
e not
>>>>> just across multiple launches on the same system, but across multip=
le
>>>>> hypervisors.
>>>>
>>>> If this is now suddenly an acceptable argument, please also merge ht=
tps://lkml.org/lkml/2021/4/12/625
>>>
>>> No, that's not how this works.  Dave and Jarkko both have unanswered =
questions
>>> regarding the use case.  Answer their questions, and I'm confident yo=
u'll get
>>> traction.
>>>
>>>  : I don't believe we necessarily *WANT* or need Linux to support "al=
l
>>>  : possible ECREATE, EADD, EEXTEND, EINIT sequences".  Yet, it's what=
 is
>>>  : being used to justify this series without any other justification.=

>>>  :=20
>>>  : It's going to be a different story if you bring me a real enclave =
that
>>>  : *REALLY* wants to do this for good reasons.
>>>
>>> and
>>>
>>>  : What specifically are you referring as the "rest of the world"?
>>>  :=20
>>>  : That would be mean that there is reviewable workload "out there".
>>>
>>> The start of that thread is *exactly* what's playing out here.  The b=
ig difference,
>>> and why this one's likely getting a different result, is that Jon pro=
vided a very
>>> thorough explanation of exactly what use case Joerg and company want =
to support.
>>> The only "assumed knowledge" is why it's desirable for the measuremen=
t to be stable
>>> across hypervisors, but I'm comfortable stitching that together on my=
 own.
>>>
>>> In other words, they aren't asking KVM to support every possible way/=
time a VMSA
>>> could be associated with a vCPU, they're asking to extend KVM to supp=
ort a concrete
>>> use case, with meaningful real world impact.  In fact, I actually thi=
nk this series
>>> is *too* narrowly focused on their use case.
>>>
>>> FWIW, KVM_TDX_INIT_MEM_REGION has almost the exact same ABI that SGX =
has: pages
>>> contents are measured immediately after they're added.
>>
>> Sorry, the argument from Jon/Joerg is no different than the one we mad=
e years
>> ago for SGX.
>>
>> It was previously made abundantly clear that it's the kernel maintaine=
rs's
>> stance that it's sufficient to offer a UAPI that allows the creation o=
f a
>> Linux-specific subset of enclaves with a stable measurement encompassi=
ng
>> largely the enclave functionality available in the hardware. Or said a=
nother
>> way: if you can take your enclave and modify it to work with Linux, al=
beit
>> with a different measurement, that is acceptable. KVM-SNP is currently=
 at
>> that state: it is currently completely possible to load VMs that were
>> designed with the current Linux VMSA in IGVM format.
>>
>> A UAPI that allows creation of all architecturally-valid enclaves for
>> purposes of measurement portability was stated as an explicit non-goal=
=2E As
>> this is the only stated purpose of this patch set, it should also not =
be
>> accepted.
>=20
> No, the stated goals (thanks to the follow-up from Jon) are to (a) supp=
ort VMSA
> GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and=20

As Jon points out, the VMSA GPA is not architecturally relevant, so any e=
nclave can be changed to support a BSP VMSA at 0xFFFFFFFFF000. The only r=
eason to "support VMSA GPAs other than KVM's hardcoded, arbitrary 0xFFFFF=
FFFF000" is measurement portability.

> (b) to play nice with multi-VMPL scenarios in the future.

It's not clear to me what multi-VMPL scenario Jon is describing that requ=
ires custom VMSA content/address at launch time other than measurement po=
rtability. It's currently completely possible for VMPL0 code to set the V=
MPL of a VMSA or create a new VMSA with VMPL>0 at any GPA of their choosi=
ng.

> If that happens to let userspace build
> every architecturally possible VM, then yay!, we got lucky and probably=
 won't
> ever need to revisit this.  But "support every possibility" is not the =
goal.

--=20
Jethro Beekman | CTO | Fortanix


--------------ms030903040004060902040409
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
BgkqhkiG9w0BCQUxDxcNMjYwNjIzMjIzNTM5WjAvBgkqhkiG9w0BCQQxIgQgV6Ld6i7ubIeK
v7lFqh4UGGJ7O7gqw1KV+m6U/Tud0DQwgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
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
DgMwDQYJKoZIhvcNAQEBBQAEggGAZw8NcalnsW+nU+RngtoKYxKzTJrKtiDejokkbK9dbUAU
dp1lXOugz8VQOEsMJ+WeJzGtAQyuMvwYv3EkFL4N/qJGxENf09yCr7rmG9g0uXtcOv6zQ2UV
7A/S1I8Etyl7U5aK3/EeSIvEZBIhsVl9c7EtGGV6dNiVCEcHBMHra3k5KYRsyraw3n+/ZJXt
IM2Zq8VLIEznBLHB/43btbTvvh0iTqL63S/+Z7IetvhLOQQlxoS+1NzJqwKArVYX2jB9Svpk
TxpYnE3aR/0Dh1nRdS98GBGdvvgWbKF/ekQRd7P6v/xPy9Xjs2lILOX/XUIs6YNeZYHks5GU
JMH1D71pofo39X1N+Lxt0nwqWleoujb6VwoL8ru8tOc5M9tPAHcyjLeqRDxm0KvN1yMnW6QL
THofWvNxoFJMMdr4jVNs4KqTOi9RCzHCqS2MyFHGCl1Q4H0XRmZgs/Qs3AuGDGBJDyI1AE1g
8i69/JouPEGtMcdS58gjSvXnNPCHO34iIGbSAAAAAAAA

--------------ms030903040004060902040409--
