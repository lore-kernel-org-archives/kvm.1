Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BD366DD6;
	Thu, 19 Mar 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932521; cv=fail; b=FnDxSa4jSV3nqQHsozGRD3GcCd8kaODiSiPAYFtN/fAhAY2Nuq+YSDvkEXjNLHQrMc+Yg/z2iiYS6GDBs1r4WVPhqnh5NRQXmZl52llFZ4W8LyPgTPCv/fJZQfGUJWOoQR16O2jKskiwKzAmqf2vXYppy9fdl9grJM/8xQ3NGRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932521; c=relaxed/simple;
	bh=fPEroHqeqa8u3tdln7hu2rC1Ew65Znn01gHNTax+jQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovxeei/JrdCeghGqhqNPtT06AGQ3qwYpzZzoBbnh+nJvKsA1ILa+5XAEAxOaLhycgjBi/09pmSVHZEcRqYKSoUvtpKk2VyE3WfyjeUuwENI1bH0eoeH8lnkSePS37xh3P5SXYGq+1OGtGdGHrtrVoAfEpTmg9IIiPTpK4AJJBOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R5W9YdXe; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R5W9YdXe"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62JAW6Ho1896340;
	Thu, 19 Mar 2026 08:01:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fl2t73U3l3rh1m4/eJstZlugUdBjnqZ48fQFJ4ywyUQ=; b=R5W9YdXeghIC
	ylaf9pISYu46Tj1XOPeZ25Acc0cUgqcakLL81i2TtabUB3gf6qf1DVHN8KVZyV4E
	laC4OMjuTD7lNsvo/6Podapisd8Inl/UKfKAOW45qvTJp3DgCvpACCdsUuljW4hp
	Rdonzh1yggtioFaAOa/ZTsTX3D0CkGWi1rJbldB8fcqK7L8O+4YBqTaHBSSRtg9Z
	JIn34Ch90RBgbDeZjcr0TZ6rHzmtjCXAQ1ucpIKzvEWFBSNErM46wT9K156Gqxif
	veQf9EKM1p21B1x60Zo+iYEj3eGAKzHT89Oey6SKn8Mo6JManLfutsE9GAl6t9TX
	0YlYQQCc+w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	by m0001303.ppops.net (PPS) with ESMTPS id 4d01wqfx2n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBv5RhWE0RyliNxZQo18YZmRhx9yxP24lyIeSk9Ah6QZDHGx3fmi11ec88tqnS//TcTqrgq//Of6seQPAJOvEW9DKcx4i+T0Fk2/7OG/OMtkcUcI7u4eDdb6ezbeDhuZCj4DBrSQUvD+CpvkCGjg9+x+Hd19OqaScVrBQjE3p3agsJffCSxE8grL3ZbcnJy87AAOc7cRao9QoxjjJFPjS+U2JxykV9hI4fLO00X3/b0qarE1Tgab/bttNnD/H+zgQhR2kXhdcQgoxkLxuiJfoz1AW/7D0Fo0EZUZ6/tDTjff8cczgzm17GF/bOlUpqVEb8QxaHURQCftqw0XmbUE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl2t73U3l3rh1m4/eJstZlugUdBjnqZ48fQFJ4ywyUQ=;
 b=LGQZ2C1I9RfqWfyp8Axe1+5O0d77teW5o867RvloeNRgqolJFMzduvEJHJHN62I3kByzopDDRPH6OKZdNmR9AGGTM80xnvGzZla+KAjiKdPzOq76xjhV1ympQIGGpquQIiaQ0DGdEZ73wjJFZTUo+mGVDAiOJC1iOmEHPK1smsqgwyVz2T83M1rPzNie30LS0N6zRmxdbLUmg6KVrBahRe2oNUNaZn3J1Wh+tOM5ZZ+18SD+11jD5ypfGey/o8H1BY3EIhBvfVgoYbfK/b24eQnY9I51bop59J6Bl14GUiMHOGqP8GoNwdp4sQwGFDgU6YN4t931mFUxQIzvy7BQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB7038.namprd15.prod.outlook.com (2603:10b6:510:38d::10)
 by LV3PR15MB6482.namprd15.prod.outlook.com (2603:10b6:408:1b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:01:40 +0000
Received: from PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19]) by PH0PR15MB7038.namprd15.prod.outlook.com
 ([fe80::617b:b77c:494d:de19%3]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 15:01:40 +0000
Message-ID: <49831efe-b1e4-461f-8efb-29b6035ed615@meta.com>
Date: Thu, 19 Mar 2026 15:01:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: selftests: Build tests on aarch64
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Ted Logan <tedlogan@fb.com>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
 <20260318165513.49c3830d@shazbot.org>
 <0cb46c4d-90aa-4ef3-9098-9c5554714982@meta.com>
 <20260319083756.34d02e1e@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260319083756.34d02e1e@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To PH0PR15MB7038.namprd15.prod.outlook.com
 (2603:10b6:510:38d::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR15MB7038:EE_|LV3PR15MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: cedac854-c029-4d09-e21b-08de85c86d38
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mldhixi3L/Wgt+qjmRtnF0jRHMuarHbSecI+CEX+h0fHpuNG9A9HWxPWvfixrU4uxcshrGpNQZb14wv5WUr6kiADCwFZ5X9sMp6HJsQOqOcS4coFM7eer50kvgq35+V0TvJtB7qCW+Q+o8XqEyhEvH4y89L28LZaWvKVWVOppIR3S6eKkEk25J2FTisTIKlOh7BTJo3gRmEKZBSa9EWJX2a3UBJaPUakRHzE+ZSYldbl6BWhp2wE6gVeqcBUaRgZ9gOEDOOKGpmyb5octXJGxBT+0pflzm2HbSeJs1ZsZj6fCJ4FpKxJkIcAa+FQBvXph+LZ+NIcFsPajbXMdfToNASWbUPW8d691fk4JzFsapjIDh1X1U0xwjZSoYQAheelNXUCs12jRCkfBfU2n+Sx/64GGNaUqGwryhBlsE1Rie9W7duad89EY1uusHIBfzCATsL5kFuBYmiAGHKgkmOn4GFFrlYRKdvC2NDD1syGvMuYrUgVWBZIGkCW99qFbDRQfLq3t+QLcTv+FWr1S0soYbi7Fy34PUBAxEAKfKe2GY6EpbTZWPqWvxM28R50KF8ujWZlejBv/pUkvRNem67EsEArCTxBAGkPp2bO8cSAwWLeLy9csciT1jzbOMkL3B/augucZjCuhfgkWxah4qPlt4Lw0KTBYcGjiI6VjOM8RgVHUPrHMbf0CrJ0UJQdK7gzBH08pDScJSX2GzwaVO91bg6UoFyIighbD/lGk5B5pDPsm/zy+OukRPuxMqksww91
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB7038.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJLTDFsb2RrcTQzbDBlZmhrbUhFazdpeGZlMWdVYjFpdGRiODF0bWNjY0Rw?=
 =?utf-8?B?NnA5RGRLNjZEN3NEVWg1b3FPY2hqb1c3MW8yQXRPcWtyckRDdmlwb1JxQTAx?=
 =?utf-8?B?QVZ5QlYvczJidEoxTTFLL245bFNTS0F3YWxJZ0xjaDZpbzJMaWlBL1lteWFw?=
 =?utf-8?B?bVIxRU81N0EzNWhQeFVIYWVuVTM5Wm1JNk80Qk9WNEtuK252c1I0b0VzeG9z?=
 =?utf-8?B?cTVUN21lcXUvS2VyN3VrMmk5ZnVtRnZXbU1FcGJ1bTNvQ0RmK3QzSjVlYm1C?=
 =?utf-8?B?QnYzelZzUTJ4emFWZWV6N3lBR0NZM0dFK0JuWkRvNktaL1dZb0pHa0dnTkd1?=
 =?utf-8?B?KzNqNzdHMUVRNUVTSzlhTTVCaU9ONFNSRk9vQ29qTUYxTmVvQ2I1ejZsQUNr?=
 =?utf-8?B?blc5N0F2YzNKeFBCWWdwM09MYXVrTFJITkZ0ZEVMcVFKNENua1RsQ3ROVnNY?=
 =?utf-8?B?ZFo4UE5hK215TE01SXM2WUw1NWwvNHNUMWJRWjAyWEhtTXhPQWNCK2xQamp4?=
 =?utf-8?B?eis4S0NaR0VQOU03cnBvT1ljYzQxWVhzaEVoUHdPN01UUHBXZ3UrK3lFa3Z1?=
 =?utf-8?B?Q1IwOTRQK1hvamJmZnhzZ09lSGhqRElSRU5MMzAyNis2Z21pdUJKZnc5RXJ1?=
 =?utf-8?B?UUsyMnFsM2o0ZGh1elh3c3pyU3IzdFU1UHY4ZmFGR2RsdndaZXBwcTNEQThG?=
 =?utf-8?B?YWc3SXdZWElsNnNuTU9KTCtrLzM3ajBCNzErQzQyM01xRGZEWjJHRDV6anN2?=
 =?utf-8?B?UmZJR1hKNkF4R3BBQlV1MDUyZXJGMDVCcGJldmZYczNpanhGYjBpWmRjL2tT?=
 =?utf-8?B?dC9XU1M1Zm9RNFJBY0VRTHJZWVJPYzREbmQxNm5YbGdaOFZKTFdYczhHd1Nq?=
 =?utf-8?B?N2h6QU9WZVJkcDR0WnBlVlFtTEhzZnc0THNjcFdVUHM4dE1KRFdqL2kxUldS?=
 =?utf-8?B?ckZNMzRtTkF4aHcrSndOMGZNbjFQZUJVMjBJcnRKdWo2WS9jdHhKY0Z5b0JE?=
 =?utf-8?B?bWFTSmo4TnVrSWFZMmI5Y3I3TFBLMHJwZzJHc0FpNklOc1pxbUk1N29Ic3ZC?=
 =?utf-8?B?bWRScmdiSTdVNXdidS9hbzh0dUFEcEcyVUxOdXVVdGNzNHBPZXFrRXkrNEJr?=
 =?utf-8?B?VEhBeTU5dzFXUnVvREk0T1dUVExNWVhQN0dBeVpqYXlOQU5GZUEraEd1TEg3?=
 =?utf-8?B?TnN0azhISDZ1aUh6ckxrZGZ0dU5BWEU5eUo0UHhLamxTa0NadytHY3ByRU54?=
 =?utf-8?B?Q2hJZXdaVjVaMC9wdFUvZm9tM3JrS1FQVEVNTVlLLzM5SDlha0c2R0E0UEpz?=
 =?utf-8?B?ekdiQ1NTdHc3elpYMXJ4VnVaOW91SFFVSlVhUThRbDU5Z1YySEIyRVI5N3Jx?=
 =?utf-8?B?S29ydDZpclBSaGoxc2o4ZHNGL2t0MGt2a2lzUnd5NStxQmRIOUFKSGV6NHkv?=
 =?utf-8?B?ellWcTRpQnJvR1V1OVhlYXEzSVdoSk10MU9LNFJPRUxGTUJDWWVaN0g3OEh3?=
 =?utf-8?B?Q2MrTE5rR0dzUGlGMmZMV2VVTis2NC9sbDFyUGttdGd3dTdIWGJzN3YwR2h4?=
 =?utf-8?B?TjZ0aGo5Uk9sVjVGWEF2SHNZV1p6QlBQL3lMMkRCd3MwRzQxUGYyalI0WWM0?=
 =?utf-8?B?WkN6Lzd0S0k4ZlM4ZnN3QVJxQmtFdkQzdW9JSWFHd3I4UWg5YklVT25pSXJD?=
 =?utf-8?B?citNWS9mWVN1SlU2dTZUcTVtQlFtOTdseU5iM01WNXllOHd1VGw2c3lZUWhr?=
 =?utf-8?B?Wml0UENmSlFtOWJnV0hFTHFRUVFXL2NYTy9kNEFsbXFHMnM2Y0dOemJieThM?=
 =?utf-8?B?R21FLzFTa1BFY2NBUkpvTkdvaVRjV3VHM3dYdUQyMlNDUmc4YjJTYnl3bGRN?=
 =?utf-8?B?ZW9Td2pFOVduMkF6cW1RMWFEMC9OL1IxTktNM3IxdWhzb1VaOFAzY1EzaUU1?=
 =?utf-8?B?MW1TZmNqR2E4V0VCcklSOHlFYWM4SlRVVmVZMjl1aDlSYTVkUGtuUTkxUVdP?=
 =?utf-8?B?QWphcFZKb0h5NG85aUJZaSt5UTM2eFJlbVpTS0h1RTlSQnplVFdDMjVRRGxk?=
 =?utf-8?B?WUxoWXZ4YnUwNUM2Ry9QbUJ5blhOemhBUHZHcTlFa2hpb2g4dUU0cmJ2QVp5?=
 =?utf-8?B?UHpDWDNWNnk1TytkRjl3YkFaUWJEc29FaWxTTjY0WUNrRlRuVU1zQjRGQVRX?=
 =?utf-8?B?bTk5bTlmalVTRkNGcFI5cU1LMmxUMHo2TitsRFRXRWNjWHoxYnozRWtGWWo4?=
 =?utf-8?B?UTJ5N3lHVDFkNW5uSDc4L1d1S3F2cWhZaGUxaWsrc3JXSVFJY0FFWWt1Z2Rk?=
 =?utf-8?B?ZWJsTEx6WDhWNmRwZm9NeGhmWnYyNmZiSG9NamFDalRuaVVBRzZTdVpsZG4y?=
 =?utf-8?Q?VjoPY12z3UErniAdAgtVOy6mvKoTrByeT0aFJ?=
X-Exchange-RoutingPolicyChecked:
	YszD+WA3oFU8as+akuS/xIpizDlerx40gTfq+YUsPGMXEwgx4Eus/IW/Q318WRm7nUYU+gzFxXY4q2lSfDuU/otuGUWa2kOgMm74mkrWTvV2QY8G3d3wxySgpLh2bP0i692tWqZZZQEo3ZcOtaSwXWrdll2gJFEUNlfmJxHFTBBP9iuQifxcWd6zN1iqp/y+mb1AbHQFWaDOn5eBCe8in1sNS7H5lATrRbwDRw9JKLNPwo/v6ynRIDu8xk+kmNnKGNKWD7dHqgjhPumDOz8Z4VAfbWdoklQvNUJa1aJqUv9Yx1Jq5gJgz06Iyn0mEwNROBuU7pbOKaWf+SVkGGcTjA==
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedac854-c029-4d09-e21b-08de85c86d38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB7038.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:01:40.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NenqrRoKu/FJ7C5BxtjLPyxTSBfdzHULx/aFOJgzq7iZ3yI4ag7JoKqTO8BAiyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6482
X-Proofpoint-GUID: 3gsAw7UY0D9GKYXHXxAzC3-S9NuZwRml
X-Authority-Analysis: v=2.4 cv=LsqfC3dc c=1 sm=1 tr=0 ts=69bc0fda cx=c_pps
 a=Y50mrEwtfcpO0Uk6WJhX1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=FOH2dFAWAAAA:8 a=m4A9Q3qvjkmAbRRmLk0A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExOSBTYWx0ZWRfX0HQbfkBrpmCQ
 HToL2oH7DfM5/LVvqsmodyr91d1HunJ3ywAJ4whwXq1oj6o7Vvs5C0VpIvrEV7hAmEtHVaDtWRY
 VLIsnwCMTu2JLBTZmbUtQFJ2T5BYMXF190v/FblhjA5MaWhBwsvm48RYO6tUwnzTY9VZa5qMTSP
 q2L+1rddM/mOmLr9FzZ2nUBtbGGuPry0YRZhYAnWTaPkBUMuO8YHvDqOBWU6hwi2nOERtBK7mDF
 LYDaCtkgbRNJ6R1OG0QZiFTKJIrwxqEdkVMXIIXMnuE9c8jtAolx3zsSg89w4MryD317EsEPs4a
 pBMZm8zMLjEfMEBj2guUaSkDOK4wG4go1Ew8ugCiSuJf7S24zu3k+2iYREcWz3x4bGwckuOD2MO
 fA6MsDL4pQC/Wd4l7JPLplt9QPu86w==
X-Proofpoint-ORIG-GUID: 3gsAw7UY0D9GKYXHXxAzC3-S9NuZwRml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01

Hi Alex,

On 19/03/2026 14:37, Alex Williamson wrote:
> On Thu, 19 Mar 2026 13:51:29 +0000
> Matt Evans <mattev@meta.com> wrote:
> 
>> Hi Alex,
>>
>> On 18/03/2026 22:55, Alex Williamson wrote:
>>> On Tue, 17 Mar 2026 16:25:18 -0700
>>> Ted Logan <tedlogan@fb.com> wrote:
>>>   
>>>> Also build vfio self-tests on aarch64 variants, in addition to arm64 and
>>>> x86_64.
>>>>
>>>> Reported-by: Matt Evans <mattev@meta.com>
>>>> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/  
>>>> ---
>>>> Signed-off-by: Ted Logan <tedlogan@fb.com>  
>>>
>>> Careful, this is a good way to get your Sign-off lost in the tooling.
>>>   
>>>> ---
>>>>  tools/testing/selftests/vfio/Makefile | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
>>>> index 8e90e409e91d..98bc8d6271a4 100644
>>>> --- a/tools/testing/selftests/vfio/Makefile
>>>> +++ b/tools/testing/selftests/vfio/Makefile
>>>> @@ -1,4 +1,4 @@
>>>> -ARCH ?= $(shell uname -m)
>>>> +ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')  
>>>
>>> Are we intentionally enabling aarch64_be with this glob or is that just
>>> carry-over from similar in the mm selftest Makefile?
>>>
>>> Big endian ARM64 support is really not on my radar for vfio, but it
>>> wouldn't be our first foray into big endian systems.
>>>
>>> If it wasn't intentional, maybe just add "aarch64" to the below filter
>>> list directly.  Thanks,  
>>
>> I think that won't work for cross-builds passing in ARCH=arm64 "from
>> above".  We can just drop the `.*` part of the sed regexp, giving
>> ARCH=arm64 or arm64_be (the latter would fail to match in the filter below).
>   
>>>>  ifeq (,$(filter $(ARCH),arm64 x86_64))
> 
> Sorry, I don't fully follow.  If we expand the above "arm64 x86_64" to
> include "aarch64" rather than distill the latter into "arm64", how does
> that break the cross-builds?  Thanks,

Oh, it sounded like the suggestion was just (i.e. solely) adding
"aarch64" instead of the "arm64" as well.  If it includes arm64 (for
when ARCH= is already set) as well as aarch64 (from uname) then it's all
good.

-Matt

> 
> Alex
> 
>>>>  # Do nothing on unsupported architectures
>>>>
>>>> ---
>>>> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
>>>> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674
>>>>
>>>> Best regards,  
>>>   
>>
>>
> 

