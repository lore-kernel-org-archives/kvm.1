Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793565059;
	b=rtavNCIjrw6LKVGd2+03iQsrjlhvn2drRp8kJUI45ZFawVM/JUqjdEfrywJbCezHkYpz
	 ZdT4UXiei8f/gtV+CmKEY7rpYVy+qCAnYhb4o3jV/LeoX5216WezjRxApWUXzYSQo82Rp
	 6hAT4W1LMPYhHHo0UO+BoWLEn+fMY/IfzK9MErdwGPJEadct92hYla87lzDq7W7gDCOJH
	 fJcx3NrXjCnvD2nXSddWtmw7u/6Yv1JnYWTn2nkAc/oK4t3srHIIjy2P2MGif+jONUlOi
	 I27dPkfYbdQVJB7a8qJplY2P2sHhT46jj89HKReV07pnBEjG7T37ZSJNFDDT7Y6kUPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:client-request-id:
	 request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=ZvtuOXLGSjYegesbfPnc3dDsHUot8rMO7TeXd5Kw0AE=;
	b=o65APugDruzOuZab4vp08MX9myGipQnD/kiNoR9C5MdvzlOrmiCV2v48+Zf1lvaCiu4p
	 EspSU/Ykw4SoXb6viR0p4bOYlYfA0VX0F85NL+6CeNdsqNpl9qEtFhWyaN88oNFIHtr7m
	 4XSZ6ZafT0Qe1uEh02GIfjlsBzdLNbtXVsLkIHA+CMBCkOnY8mDeCJ4lHMuTDsLToHmSb
	 uHg7jc3kbvo5V6h7XqLWHdy9fCOfSH/p/fnk/OKULkc2qGWOTvzlShpUnoBlz85NZL6E+
	 KMkGgBMaQfVI03Aw6Kr2lDI+RA14TVp7NgDJI7pynTMhdPHcFd/uWdJItZ8lhwPweew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="mi/z5isN";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0EQUQ8Hi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53776606A324;
	Sun,  1 Nov 2026 20:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53776606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=mi/z5isN;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0EQUQ8Hi
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1K28Mi2874947;
	Sun, 1 Nov 2026 20:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZvtuOXLGSjYegesbfPnc3dDsHUot8rMO7TeXd5Kw0AE=; b=
	mi/z5isNhEsF+Xgf2qhMvIMFQ4EeuZxSImoHo05xrTVhn668H9msy9K/gT3SD0vH
	DgLvKdsgr2Of2SHi7XpFQAjspySNqtOtw9cP7N4xZoLy0+9ZqrxnLQjRLipGYk8B
	q6Wt7SlzHWpv8GUFtoGdECW3mrqZW/yD1loXgxRaP8weT1cmunHJ//Ejj/ANrhsn
	VmYNGhErNwqrtLPo1+XhHLHixPswbq/TcCM2kmzHkQfin//+6+uUmlv4zGYiFBJv
	O2URh4Zq52XBwlpNzSGl/yBhWx5mOvFqM3KgXezb/Am7E+aZmZLVGjwiL7FhA1Jq
	+E0S5ME+8y55NYw3URgknA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x011nt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 01 Nov 2026 20:30:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1KI7s31436524;
	Sun, 1 Nov 2026 20:30:30 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hp6ffwp3f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Sun, 01 Nov 2026 20:30:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWLNcjskj2zQqoVsCuJ1cmq7thtFXlPXJGcadjQ88ttQ+IuiMMg1XCh2sF1GkWij/fKGNjSGX0UpTXFSq686ej0ePb4lySUdXVtAxJ2qQFpbDJVXRliu0+1S+ypaGpBW/RPZaDDFGeTPl8lrC7aD4J8awyZf/hUZgc+bdLGElHItpV5Doab/ElPKxdSQeIkXNF+Rf3nu8ih/AQJBafhW/Cblb2a8O63q0XddzBXDst4aUTlp73bKXuZBVewfZN8h+XBPp53/WynzZEILxw3A9L9eRB6COk+vn2vkimwqK9BYevfs1b6naLMhRsOLoA/0uMVsY1byJkeA4nFZYe789w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvtuOXLGSjYegesbfPnc3dDsHUot8rMO7TeXd5Kw0AE=;
 b=EgH9poW48nWNyLbU1dJHTvlNIvG/GMseHgVMWv2f/5EY3Wkp7rf5FxVIYTgSoXaqd9zk2/OE3LO7uJQqM9k8XH/2vGf6YzZaUU5msnYW5ZpkQRL7AzdC0iA3milQsz/3H1LJorRdPnl0WW2KrnHoq+WRHwR6iL4eU87khkGNBRGyTH7KknyrNb/UTbwjHE3ESxaeTfAVp/FlrfIAYOoMKSazK5JE1d5Bd10uBCa70F9jNYuq74bEOnQ8asKCRfiUaLjY20AEhlQukHX/u+JGJeHJxtJRoQ7i8mpzmM2xJGSMDJFjisCBICl3lGtBc+/plqvKKZZJRkyGJPQOujrHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvtuOXLGSjYegesbfPnc3dDsHUot8rMO7TeXd5Kw0AE=;
 b=0EQUQ8HiNleS2f/B6yYu4xVzsi4ht5vLVzjwhW46i6dH/u7m609cyVwaQJdLOMLzXpuHctXm6lxoQah9dOqgRL8dzsHK0xAtDKEX0eNMauvz9N8gELrFA4uXe84KKIAFz73NZW/T1akmYqAeK1l8ffviHuGG0ZJghnJ35RvFkjE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by DS0PR10MB7936.namprd10.prod.outlook.com with HTTP via P2P; Sun, 1 Nov 2026
 20:30:27 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0546.017; Sun, 1 Nov 2026
 20:30:27 +0000
Message-ID: <eba55a4f-458e-47bc-be53-e72fcdb03f08@oracle.com>
Date: Sun, 1 Nov 2026 12:30:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] KVM: x86: Keep kvmclock_offset monotonic across
 same-host pause/resume
To: "Chenzhendong (alex)" <alex.chen@huawei.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: luolongmin <luolongmin@huawei.com>,
        "wangyanan (Y)"
 <wangyanan55@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <e99489abf983494d888f04bb0f901e06@huawei.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <e99489abf983494d888f04bb0f901e06@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::11) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|DS0PR10MB7936:EE_
X-MS-PublicTrafficType: Email
client-request-id: ef5c4b15-14ba-40c5-abde-c624cd47a66b
request-id: 9420a6fc-a672-41be-a5d0-08df3856f6f1
X-MS-Office365-Filtering-Correlation-Id: 9420a6fc-a672-41be-a5d0-08df3856f6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OcoVexVrW5EREzYcoChRKS5rRO5Yv86KTpvc286r9SNBNSKY4+0r2HbVZeuZn3P+z4niIZqMeP1MVHdxyXU3YCUJKM0LUyuVy4QvwS98mmi81l5DxnQ8nTdAT2h8WOIXmR0GC1kKfAHjVNQHRZWQX40rvbu2d+3Zhpt+ZgFL4oVCMN31bIyju5yWvPq2ddgyaP6DpeAUiOygluqh8/N5lxa6tsC7TPNn3TxLiIfd5Nb702NKfZ4mvgDgkgiKee0H76feSIjx+siCWKJuSo7hmL3W/oevHPbxbQUlTKD1ZS/K4wWwRmAUHXAFI5EYI63zJQec8shD6+LGAAg1O9QGcoolSKBpz9QKG5HlgkkJhkUVVv7pq0iK7782JkE2vE1uTVrVA+KSMqsN9OU21ZkoFzsdE9tyr3/gkJufnlKRs0xldEvYDbkd6Slg4O5oMA7UtnhIeyASP0oAu6VfyF7NtekLI/rl266yKnLrzb8vvtGrIw6j6AaNB7QnSJo5AEr6AhD/qz/yUv7/6SCIH5cXpcxcTWvEMgdBbIatI1v5OEUtsJI1Xr1GkmSX0h0uAVZD0ZqLvzS2ePV/C1RJBmpdTTXOu4tdentAdolzaD4geV1P2qXUttOXNJTd7lrODP/B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZuZit2MGVZSGhZYTNFM2NjVmJGTUo2eWx2VlYzM1ZuUkk2WXViaDJKRzF3?=
 =?utf-8?B?SDNJRVB0eUs0UXB0SDc5K3duSjVGUDhRdmI3RTY0Tm5GU3ViM1FpdkJnMTBD?=
 =?utf-8?B?WkQ5YnhXRnhoK3ZySjNZS2twTnJaR0hUazhNZk1TZ0pDVklVc1RqVThMMVF0?=
 =?utf-8?B?U2txMEVXWmsyYi85ODRWZjdBZXpITGordjU1MlFBa1paejZqaG1jeDF6M3lW?=
 =?utf-8?B?Y2FRcUh2RkIrSkR3M2p3Wms2UENkYjYrSTlKbmdpVHNBWG9EMDVCN3RnNi82?=
 =?utf-8?B?VlZ1bHBmT3JPSkFSbDNWQ2FtY2JRRitMRUp2dUhDNU1MUXIxN3UwM3lnenFP?=
 =?utf-8?B?Q3JKSU1mZW02c1IwZ2JsNTNuUmw3RS9TeXF3WjZYT2ptOUtiSy90Z3lLR1Fn?=
 =?utf-8?B?NUplVW5CdnFacUxFZzBXcTVuTjRKeVRBMmlYelk5eTJDei8xUnExdDYvMlg4?=
 =?utf-8?B?bmZIaEpBQnM3TjNtbFJoZm9ib3Fwc3AwZ2JKTGxPck5nbFBpZGlHSXR0MHhq?=
 =?utf-8?B?ajR6TE5hNVlzRU0vUGpldGI0VDh2ZFk4dFdaSjQ3YVErTnhwY1FWNE15bzNY?=
 =?utf-8?B?dC9lbmw5RGN1YjVqcWhLSEZYeHorZEJGVnFrQ0ZqVzl5eU5vQitqTDYrWG9u?=
 =?utf-8?B?OGdnd1NnNVpMMXcvTjUyYkZVaXVJNEpKVkJrTFovRC9xNWtXUE5tUHRYVE5F?=
 =?utf-8?B?MzZQdWU4RmN6dVFiZjk0T0oxOEQzNDF2UTBXQWNxVVFLY2xkNkNuOENtZ0NB?=
 =?utf-8?B?eDhiOWxVd0kwUU5VMEp0N0ozUFl5MVdBTXBqS1FueFZrakNPQnB5SkUvZ1FB?=
 =?utf-8?B?NDBqMmwrd2hiWTNWeTljOWJDaDhoNnhYQUVVL0hXU0t4Z2FOQTFSV1ZKM25t?=
 =?utf-8?B?Rm5Wdi9BaXJ1S1hEME43bm5LbTkzK3pKVHdYeGtEK2FScHVPSExqUUlDUjRL?=
 =?utf-8?B?QU56eTFjSkFZbzc4TGJvblQ3SmRNTFFYODRCWlZQWWxoOWg1dHJXYWU5QkVw?=
 =?utf-8?B?VU96U2Z4VUNYRnFvV3dyaUlTTTZwS1cza3lrNTZITXh0UUFIRVlZZlZOWFVk?=
 =?utf-8?B?eWJick1oM0ZQZWF5Wmo2ZURONXE4a0ZieDREbjRhNnRRb2h6cmQrWk9VOUc1?=
 =?utf-8?B?cTlVeWltdG9zSkdjd0RLei9wVVRET0hTSlVOUjhKRFU1enNuNWpEcWZQeEFx?=
 =?utf-8?B?RUtuU0dEcWtjWWc5eTd1VVpITDcwelRiU1J4czB1cTZYMFFXMkh1Nk5DWWhU?=
 =?utf-8?B?M3F1T2lDNFRIQWMvQ0s2cFJkVkRLc2xsWkx5c1hpVURLYi9WdlFrTGk0WFlY?=
 =?utf-8?B?dTJlcDZyV1N4UDF0ODdvSG9mUGNVNjRURGNLcm1yYVdveENJNXJlaGgwb1JH?=
 =?utf-8?B?emJKZEw1NUs2WC9CMVp1elYrdSs0enBFRkhua1JKbjk2TlM4WEYzbkVCQ2lk?=
 =?utf-8?B?L3hVcnpWaUI2V0RqNDFtOUhGRTBQTVFPTlBSTEQrNE1TWDEreGJTdEU2VXA2?=
 =?utf-8?B?TlZ6Z1F4K1J0UEJFOG5uTFpTd2loeW9YS3RqYkRvMkw4M01WLzk4cmhydVoz?=
 =?utf-8?B?elZDOEs2N2sxUXh4cTB6YnRlcERKTXFhTFh0enlLTU41OXJmdG1SVnpJQVVv?=
 =?utf-8?B?Y1M0UkVOaHJxdjl4YVJXdUZDYTQwSWhvRmZmcThSTmNMV05vNGJQcEwyY3Fi?=
 =?utf-8?B?TXp6TTlNTG5GR3ZDM09kU3BIVjNZd0JMT09NeTcwMTVla29lSWxnN2thRHJ3?=
 =?utf-8?B?SUZzK3UvK2FwamRYbXRVQTNVbWlINVlwV3N4emVBUU9QTXhXdys5M3lvMW9i?=
 =?utf-8?B?aTY2UUFRM0twa2J5cUJycGU5MlpySFdSUG9LWVVjTy9UQnh3TW5DamhhKzA1?=
 =?utf-8?B?VGpaS1ViSmJMY3RhRFNaNGRkQTVKQXl3OVB5TkNENjNXRjFpNFUzd0ZzMDAx?=
 =?utf-8?B?cVc0VWxkcE8wRW5jcmlrSy9TUWxVQTJuL2UvaitVUHRNSS8zRzVSa1ZOWklP?=
 =?utf-8?B?RGVkb1NWSjhEUHdvZ2MrNlFDdmxGNys0bGlySVhOcmxOMmV1RFQvalZlVVFN?=
 =?utf-8?B?UFArbURNdmUxYmt4aWc3TVhtcGs1Vzh5ZCtGeXVTU0JFUVJXZyswUFkyU2Jn?=
 =?utf-8?B?bXJGY3RiTS9UMGdSOWhOa0w0K0hVN2hPL3ppd3FHMDJjSVpIU05XOXdnZ01X?=
 =?utf-8?B?NGZWOEM4MzNsY2c2QW51Znp1UGhzN09Dc2NwM2V1SG5vbWpDZnc2Qm16cFZK?=
 =?utf-8?B?OS9yR21mVHViOTNZdWVjVlkyUzBHNlJOeXN5RkpnR2UrMmlpUytuSmZ0elZW?=
 =?utf-8?B?a004NkN5Q3VnWGFkYkxPbjdIWHZqSlQ5YmQzNGUwN2wrb3dLUzVVdz09?=
X-Exchange-RoutingPolicyChecked:
	50ADlzYlg8MXzY0ReLVjqCYoQm+0FrbQC62ozyL02kocQQGqrQy1svIvsn1Elw4PdKY0kIUDtI1CBVSp51nmFoMP0ZGogrlbFifMrppnAGZBhiq3kYBgOg6j+6oQyPQwKbxckflW7ewPQI6YRWziIP7NARpdUsqhnCDENiSCNXEeuewi6wkZ16MsjXtlgzxvlCS9vZ33kh1Z07xfnY1oDS+FWiM0D1RZLbs9WPdckU+c8cPEcPF97jvB2Wuy3qIPEQkw4TvVmHY0CVBsUVkspMSIAtm0xMGnx988RKI/WgyhAdN1GDzAbGUe/X3ioEgr/FlmQoUofRJnJAFyRz1ytA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PQuO+a3p6tBZH1pVMcvV+ISDVMSNHP2JqrUCREIc8YQGTA6B8n3N6KZt1IxVpAYPLLjY/h8z2Z723ahgZor2lSGbYuCYoFnsYDEXJglodQcFcsxtwxr3j+6QFny/Inh3CA2AVWh5jdhUMFyUET0Jv88G6VvWKUDSGKC515nzRdS0IOMMH8dg/gnJvoDP8uMhYstD9KuZ8YwMKgZX2e5wZPbwrzvA0wvMHeogYaBrCWFmhQyZcItoxOgf+njF6E6DbozVq/J5jHLx/Ah75QR7i4YLHN4C3vYe/+/hraFajkNLxDFwBUazSstVz9b0rXsEK3zqsUfnMIJ7d3zKDhfs7ZWK5ABsllZtCYMSH1D0Z5gLBPefutLZ8ct+ZbAWl7952siGPg2BYQyoZ/eS4EUY+KoOj6bPC9iRfVI0tFP4eJUB6VqpptvwRxDXPWQN1l8HyBdNL6uznFmBFHQ1feivFZt2zYg2+F+j/NZMalRzBbyPx7zaO5tyFfylz/65gkWK5VdmdZloIG/dsT9b4Je5eOdXGOyrDx9448RUafoEPQhXCm7XjHe5V+FlNlU2tFP5wxMVrn75MoZLia5GyFsu5rCsnFDw3TbUwOtiINeog8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9420a6fc-a672-41be-a5d0-08df3856f6f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 20:30:27.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nWXQkQtT6gDNE5gxqjxAUxESqF3IHViee/HPBv1p6qR0k3cMtLV0isSWkkQ3uLiGGMbngw6X+RQqQioCXd0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=-999
 adultscore=0 spamscore=100 phishscore=0 mlxscore=100 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010080
X-Proofpoint-GUID: 3GRCqAzL_BD1sbag6oP2Ncr-CaZRvs4D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfXwAqRxYXHPu0e
 sh404CJzbtzSr58tA1OgHxlUh0uTU4TCJ6S9es3pxKkZFChnje0V9cXc4IlUF+ZFSVzLnEQ1YY1
 yZd1peO2vuH2qtPYr+HzysQmAt/RBoWoe1uVdoHTtkApQQqCZWto
X-Proofpoint-ORIG-GUID: 3GRCqAzL_BD1sbag6oP2Ncr-CaZRvs4D
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae7a166 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8 a=-TDe8IugaqCPtgTXhe4A:9
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4MSBTYWx0ZWRfX4GW8PR5E77A7
 f7W5g9cStKgy0LWWtMXmITIq++y9eE5CNELuhujO79HepyfjN1jCp4RnSyc0Wy1k2BO7gjlI6py
 T2wvKOTafI8ldRaaRaJqdhGlX4SpSgpPRteVLw0rfc+x1gIcIOfRHkayn6aB+O2zKclCuv1SoBG
 7qYYZgo4wvtuakYIUfhAGmuJ6wYOrdF/a4f3gBjeQ5WTIM4ofH1f8dlEbjojrKL5uOHflY7qKyG
 l0Oh579wVFLi28TSeSHLsL/f75D0UW3+k82katR4Ir3moxYKIdPt2/z2CGT86fB11DwbX8slb2F
 tmKQCeIoS3OYwhCU8zdLesf1qeH7asNCvSRmaf4cDT6N4tyzKghiAS6ZSdnm0ppuL3obQKdq/Fu
 F93HcxOnemgFBAtjBr4vmZwsUoZ5Xhq4H0Do7mXADL65uSog3IO0piodhq/CVl6p+Mm12AuNhFs
 MfQ9AnzoKcYSrsK+u3A==

+ David.

FYI there were some prior discussions related to this topic.

David has a patch at KVM to enhance the KVM API to resolve the issue. It is
still not in mainline.

[PATCH v7 31/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock
migration
https://lore.kernel.org/all/20260728144954.355376-32-dwmw2@infradead.org

I used to try to enhance from QEMU side to avoid clock drift while accounting
for downtime.

[PATCH 1/1] target/i386/kvm: account blackout downtime for kvm-clock and guest TSC
https://lore.kernel.org/qemu-devel/20251009095831.46297-1-dongli.zhang@oracle.com

Here is my RCA about forward drift and backward drift from another perspective.

https://lore.kernel.org/all/935312be-9a86-49fd-8bb4-2c998a68e2df@oracle.com


On Sun, Nov 1, 2026 8:19:14AM -0800, Chenzhendong (alex) wrote:
> Hi,
> 
> While testing storage snapshots that suspend and resume a VM on the same
> host (vm_stop -> snapshot -> vm_start), we observed that the guest
> CLOCK_MONOTONIC jumps *backward* by the freeze duration after every
> resume.
> 
> The problem
> -----------
> 
> On a same-host pause/resume cycle, QEMU saves the kvmclock value at the
> freeze instant (T1) via KVM_GET_CLOCK in vm_stop, and feeds it back via
> KVM_SET_CLOCK in vm_start (T2 = T1 + freeze_duration).
> 
> kvm_vm_ioctl_set_clock() recomputes the offset unconditionally:
> 
>     kvmclock_offset = data.clock - now_raw_ns
> 
> with now_raw_ns sampled at T2. Since
> 
>     data.clock  = now_raw_ns(T1) + old_kvmclock_offset
> 
> this gives
> 
>     new_offset  = old_kvmclock_offset - freeze_duration
> 
> i.e. the offset is pulled back by the freeze duration.
> 
> The guest computes CLOCK_MONOTONIC from the pvclock page as:
> 
>     CLOCK_MONOTONIC = system_time + (rdtsc - tsc_timestamp) * mult >> shift

CLOCK_MONOTONIC and kvm-clock are different topics.

I would suggest here use kvm-clock or PV clock.

> 
> where system_time = kernel_ns + kvmclock_offset is filled by the host at
> each vCPU entry. After resume the host re-samples tsc_timestamp, so the
> (rdtsc - tsc_timestamp) term starts growing normally again and never
> goes backward. The only term that can shrink is system_time: because
> kvmclock_offset was pulled back by freeze_duration, the new system_time
> is freeze_duration smaller than the value the guest last observed before
> the freeze. The guest's next clock_gettime(CLOCK_MONOTONIC) therefore
> reads a value freeze_duration smaller than before the freeze -- a
> backward jump, violating the invariant that CLOCK_MONOTONIC never goes
> backward.
> 
> The fix
> -------
> 
> Only allow kvmclock_offset to move forward (or stay the same). If the

Ideally, neither forward nor backward drift is appreciated.

Thank you very much!

Dongli Zhang


> newly computed offset would be smaller than the current one, keep the
> current value, so the guest clock keeps running forward and the freeze
> duration is simply skipped from the guest's perspective -- which is the
> expected behavior for a same-host pause/resume. This is a pure monotonic
> protection with no time threshold; the normal forward path (guest boot,
> KVM_CLOCK_REALTIME, cross-host migration toward a later destination host
> clock) is unaffected.
> 
>     old_off = ka->kvmclock_offset;
>     new_off = data.clock - now_raw_ns;
>     if (new_off >= old_off)
>             ka->kvmclock_offset = new_off;
> 
> Test
> ----
> 
> Inside the guest, pin a vCPU and call clock_gettime(CLOCK_MONOTONIC)
> twice in a row, flagging any backward step. Over 50 snapshot
> suspend/resume cycles the backward-step counter stays at 0 with this
> patch, while the unpatched kernel reports a backward jump on every cycle
> (measured freeze duration 27-36 ms).
> 
> To the best of our knowledge this scenario is not handled upstream. Any
> feedback on whether monotonic protection is the right approach (vs. e.g.
> teaching QEMU to feed a post-resume clock) would be much appreciated.
> 
> Signed-off-by: <Alex Chen> <alex.chen@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 19 ++++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7a0d0e8e5c1f..000000000000 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -XXXX,XX +XXXX,XX @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
>  	struct kvm_arch *ka = &kvm->arch;
>  	struct kvm_clock_data data;
>  	u64 now_raw_ns;
> +	s64 old_off, new_off;
>  	...
>  	if (ka->use_master_clock)
>  		now_raw_ns = ka->master_kernel_ns;
>  	else
>  		now_raw_ns = get_kvmclock_base_ns();
> -	ka->kvmclock_offset = data.clock - now_raw_ns;
> +
> +	/*
> +	 * Monotonic protection: data.clock is the kvmclock value userspace
> +	 * saved at vm_stop (freeze instant); now_raw_ns is sampled at resume.
> +	 * The naive kvmclock_offset = data.clock - now_raw_ns pulls the
> +	 * offset back to the freeze instant, which makes pvti.system_time =
> +	 * kernel_ns + kvmclock_offset jump backward by the freeze duration ->
> +	 * guest vDSO CLOCK_MONOTONIC goes backward.
> +	 *
> +	 * Only allow kvmclock_offset to move forward (or stay). If the new
> +	 * offset would shrink, keep the old one so the guest clock keeps
> +	 * running forward (the freeze duration is simply skipped from the
> +	 * guest's perspective, which is the desired behavior for a same-host
> +	 * pause/resume). Pure monotonic protection, no time threshold.
> +	 */
> +	old_off = ka->kvmclock_offset;
> +	new_off = data.clock - now_raw_ns;
> +	if (new_off >= old_off)
> +		ka->kvmclock_offset = new_off;
>  	kvm_end_pvclock_update(kvm);
> 
> 

