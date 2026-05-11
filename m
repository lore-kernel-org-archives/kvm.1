Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0115313534;
	Mon, 11 May 2026 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534889; cv=fail; b=Jh/bnPcHOQsbi7fkyk7VUUTKzMAGTZHKe4w3Kx10itoZAQKszeuk1XvxkoJA9B96cNt3PCXt2dV+hvL5ohvpoX/dKFp98tOYLZjDWcTZOMyDWdSDga0x7vk+e6BvFrDpyDF/P37vWYVdxlO5EJKacxFgAkoELtZlrrUc91nN6ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534889; c=relaxed/simple;
	bh=pZtrYKhvMbEd+U37VI+2bV5AuRVdddqjNAHygaxqq/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NelYxnyc05Ms1PudCsA9T4eh6J3PYJz8/CDVFR8uc3LIp6teGryh9az1b+fC6HwlvuZwY5rlYJ27DkAbCibVn8z6Z6+PAynnnkCmE89wMpW5fbWMv+gr8QWl626nKWxnhgB0XBRmJv/U+z34JnCxQLdDfRWslXaqUI3fukAoVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQKaYuum; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jE9rkGx/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQKaYuum";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jE9rkGx/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6o5Q2046672;
	Mon, 11 May 2026 21:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W1h/maw/oHs+LQA7p5yCQG94ECwErtIUyRLv63nT+tA=; b=
	VQKaYuumm8RsjbbYivkaXci2SL+hAeOk5yPeBVGhFPdsxcvuCGqqY2t/KvzxGLRt
	Z7MwEEBdvwC3LDL9dPhH8ouyHf9reOEhizFG9CbtljhLPajBTjl7X48lmgIIcpNY
	epmlusFFGOMXbYbektcyWiMDOtqtpwUWNNkv4tZ4oSch8885dtsSvS2nHwCgxVhX
	cs3oko5fJHhcbUbxpSfetqWS+Z+5beSbDgS8zMf7molcs3Y9aR3L6Hjyjl/WgW8D
	walSu4VNyLQ+x94KRvBccnfDryvVSZl/ouehewgDgDqjupfEgr4N6/CKshWGBC2/
	RrIcUYKGMXAdXq+rzkO/kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv284pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:27:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64BLQKeV012169;
	Mon, 11 May 2026 21:27:33 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e3neg3mkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 21:27:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSWVtNPDV5YxRFDsYQJ3C2mdW0c+KmNiOErUETGLBUPsuVJ1/iIk4V9UyMM64SEc9tt7PPzVM5o7RMO/hb8eicLILR3aRlNUm96GUhuUuPuL8M8FTUQJrZX1e5qXHExt/vktbc8o8XEDGxnVL3ieFzy+DtyQLI2JqB/WjofOmOdnqpiDgdf9i6s6HzAAOXZnEw70FAAyfxdsT34eNNOTdUqyb6Gzy5Q3Bnp4j/SqJQUT5ZUy5t0zwvKZ6uOQPBD0srIHwWVZtnXFmjTZyNbZiiwBTn1VF57wkZG9LFovNywhLhTqdzZTsmiqL06lT6sjvNjMkCrd4n0zyV0GeF1GpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1h/maw/oHs+LQA7p5yCQG94ECwErtIUyRLv63nT+tA=;
 b=eDJ5c6YkfvTE4rLsSIU1j+bcyHn5sb1JveEguOTyUXGSPtx5Lryt9v99Iv0QSePywLCrrUZCUgzT4xQ1cLOSsVXF/wWQzdHsKfNrxeKuGqEqHUchyMADP9C5D9uwZcNYxOn8na9pppXe71K9LTZToS1zgkGN0kJ27Z7ML5HyfgPJ0kUgrjWvuTB/kIrbOM/atsjsv5fRrEG+862Z+pbv3UArAhLkmf70U8x+i0hVxlNGYBZDh/rnp2j6PIvwrw/uXdEzG3iLGRvvLomdkxqC6Jd+b8SGTEsxXZZq2AfthTQu9csqVzlPk7lkQ50oYNR/OqHaGoLKbCQ/TvOImaEv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1h/maw/oHs+LQA7p5yCQG94ECwErtIUyRLv63nT+tA=;
 b=jE9rkGx/jr8AiYT21hAMblry+r1SDHIbTyr2FfYJYInMe6TjkTXUnPs2U+/t/tPNtYWKfP6JnyTB+cNpsSGQVNikcpb3KB1rz40TMPiYSX293oMJL5uMp7en7E51OyiWHaAUyqlSaqcZ2UFThGp+eyihOlCn9VVUh4KiHUnOh1w=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by PH3PPF67E073224.namprd10.prod.outlook.com (2603:10b6:518:1::7aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:27:28 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:27:28 +0000
Message-ID: <53a294f2-1812-4ccf-9bc8-c61a93588564@oracle.com>
Date: Mon, 11 May 2026 14:27:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] KVM: x86: Reset vcpu->arch.st.last_steal when
 enabling steal time
To: David Woodhouse <dwmw2@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, tglx@kernel.org,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        shuah@kernel.org, hpa@zytor.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        jgross@suse.com, joe.jin@oracle.com
References: <20260505003044.78693-1-dongli.zhang@oracle.com>
 <20260505003044.78693-3-dongli.zhang@oracle.com>
 <af5mbWXpG5ofRdJ2@google.com>
 <c5c38b0f7b6ca0da69152698913b0c68e185e5c8.camel@infradead.org>
 <2b409be867cbd9b83087203302a86594553050e1.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <2b409be867cbd9b83087203302a86594553050e1.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|PH3PPF67E073224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d690341-e279-421e-15c8-08deafa41a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VTcXaRyTtgpob8v3DV0TdIdbZihkdW0/j/BREBFs4lKlnFElnqdSiGAwXa4zPJIfJyTbxavHmeyAX8q8U66fXdiKDEaTDNqL/AHgB5ppMAMlabJPSNVX8rutxhyr+GUzadLs8fcP7cjbdKEtVVymQs6qu+HXD2J9ksq3VcEyArvFpnxmjpwZeY+JQAyZDdkDmIJacMkWrBuwDkchpSRtmA/mRf2zCjRT/8v87or6LxbvfzYyXTp/i0zxmrENcLv1OQKefJT67ZRlK54GOJP9xC2cuoGhKtWdPHPWMOOF6HRlV307/opl5DHDy+eRMGdWwO6JU39V4v/wF3TQiZVZdVwKNM88pn8X9sbB4vJR4my0G/7ngpS/y6GHxg0wzJpmrYmekpXXZqTkDr6svGPZjemrF1hX9xQy72WboBrb8vILFzT4mxERskgLyT2HyOLutDnG/Vxuq7ydf+fruShIAYMeODyXWnmQ7VVA3bMElNt1hMoP0A/WW5/mljtP+RKAgpo5E+zGY1gAcutoUfQcS86E+JnELqq1LNyAC4qr1j1LbxhUWcGeF205KqBrCM8FMwc/m6jXjhOe4NU3Thk7ZV2v2pj6dGyfAyjMKeeHb0QKWxqMpD+l6xcAV1CUUtpBTXvUzQKf2McNWjruzZ0VDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXIrT0pKN3dLbHRHcUM5QjZvT2FJdU1qM3ZqNk9xSEtHK2ZpYlpmdzVaLzdt?=
 =?utf-8?B?Ulc1VW5QblcrNVZPZUlKbXVycHVhWFI5QS9tMjhTVW1vTnJ4T0h5ajNjNW1H?=
 =?utf-8?B?VjJrQVZZM0ZiZVBHMmxGVEZtL2tMbVJDRGFwMU5pS2lrTi8yZEF4cDJrTzVl?=
 =?utf-8?B?dEQ0ZEhvQ1poc1VnRkpOdGtkZTJBdWpQbU5XMTFURUFpWkVUNEQ0SlJKd0F4?=
 =?utf-8?B?M2twOXR3VmdLNnh0Ulpabm4wWU9WYTJod2NCSW9kZko1ckplQzkzR2Q4bU9t?=
 =?utf-8?B?Nnp5dTZ1dG1YaDRucTMycTZiOXNaT2FaV2ZjUDFxOXRtTndUY1A1aE16L0RP?=
 =?utf-8?B?QzFMUE5Wb01Gc2YzbVdzbEIzUU1lT2Q0QmczOVhBMGhqekRBZFAydUZlZTl2?=
 =?utf-8?B?VmRYR0hUbU1XeGgwdlM0QWRpNmluRmUyYytLM1JuTmZVUXdHVGthSW54OXRF?=
 =?utf-8?B?L3R2UllOaURKNXh5ZDg3SEozUGU0ZzNabkJkaE94MTZDa01BZksxRzVNS0xE?=
 =?utf-8?B?UWJ5eC9YNkI3enBNM1Q3VXJxclhmMXpnUXB1SytDNUxEZFpHemlaNkp0Q3l0?=
 =?utf-8?B?OEo3a2NMSEZxTzByWVBsSjBwSXlxV0dCclpIVVZ0Zm0wWGtRM2Zna2dtczBx?=
 =?utf-8?B?T2xNUktNR2Y1S2NWRVZjNGFIYVBxcDdVZFdvSGlSMDJDRlk1cFlwamh1bnJy?=
 =?utf-8?B?dGYyVzlnbFEwZnZHOFI0MjRIYnhyUUpTaE5VejdyeTJIQlRDb1p0c1gvQi8y?=
 =?utf-8?B?RVdETWFJMzF1STkxUzU5V3YvcnFxQ0NNOHY1N1B0cDdpdFZ1U1kyeVhtOWFJ?=
 =?utf-8?B?cDVza0NXNkxVS1RSRmNOOEFZYityN3dubEhTZUNwUnFWZ3oyallZQWpFYzEy?=
 =?utf-8?B?TWhSdzlnTll3c09JYzNMYmpoaGpyTWl4bGVJNXhTaWR4T042V1dqbis5dUhr?=
 =?utf-8?B?MlNYdHB6eXhHL3EwdUtOblRSbHJtTXNsLzllK2Q1YzNCdG9jWk5KZWF3RFlq?=
 =?utf-8?B?VVI0cVZUYnlNc2h3TjBKdVNSdWR1NTZRcHBUNmtMNmdWdUdhUk9MeTJXQU1R?=
 =?utf-8?B?SHQybGhhQkI2cUE1YVNBeFpzNmxHMll6NmJVb1oxQXFtMEZpODhVU21RbXpG?=
 =?utf-8?B?Vm5XSlBrVVVHV0NudFdSVHJONmtUeDBSVnZNT3dOZmhnQ0FrMWRvN2VQd2Zk?=
 =?utf-8?B?dUZZR1JNVWFhWlNMSWs4QzFOK2FyNzhKZG5majAzNWNmQXBLaTJRMTE2Vjhh?=
 =?utf-8?B?alh2ZGVNSWJmV3g5MzljREgrYVArZTkyaFdoQm1XUTBFQ2RqU0VOelJ0YkFm?=
 =?utf-8?B?dXJqdXVsVW5nNXFUdEFYL2pTZjhCb0p4RlJwakxrb2kxTXhrRms4bng2TE1N?=
 =?utf-8?B?MWVsODM5aSsxQUZYUm5mVGlma2RzM1NiVCtVU0o5SEw0Ri9iU1M2V2hsc3Va?=
 =?utf-8?B?L1ZRckduSlNCK1J5cTEvWFJrZmpKTXE2NHZYWnV5KzdlUlhFcmFscGQ2QXBr?=
 =?utf-8?B?MTBoYm1HZDFKRzRmK2UxRGFkaUdjRlZYQUhxLzVzOW9VT25yc1MrdTFrSkcr?=
 =?utf-8?B?Z2hJUE9mV1o2SENVaG8ySEpXMnc3VUlPckx1S2t0UGdrajkrMW1FQ00yS1hn?=
 =?utf-8?B?d0pjMVhMWGVUa0s5TmR4SHdXNmVaRU1VTVNhS3BPeVFOVXUvRjNMSDI5TWxq?=
 =?utf-8?B?NTFFdkdpaU4zbmxwbWdwSFlQUzg5anRBT1IzRVNGQ0VrQ3k0OFJpcmN3VUlp?=
 =?utf-8?B?ZG5Dbm9KYUFidlZnYzNUSnlScm1YR2pjVENSUGFIcCtRR0ZiMUVwTW5lU1NF?=
 =?utf-8?B?bGdQVmtrN0NFbStBMjhhbDY2YXhMU3MvTDhkdE13QlNrU3lQQ3MrN0R0dGRH?=
 =?utf-8?B?YnNHNHFmYkxNOHRwTndtSmdEYnRDczJuTGc0WkxMTkZDaEtjZE90RHFJWHIw?=
 =?utf-8?B?REtaNWliTHVxYW9HYXJpcElFNkFwNzdMY0FFRFVpemhZTzVUeVJDYUZ3NXds?=
 =?utf-8?B?aElWQkxOTHh4L29LT3VYZ0tsdTJ4TG9qOG9yK0x3M0M4Sm9qZGxpTlY0R3Zw?=
 =?utf-8?B?UTlZSTQ1SEp1dlp5U04xcDZQMEtFZ1M2eE4rQVA0N0l0aUZtazhKSlFCUHhl?=
 =?utf-8?B?bUhiNEVvZVFzMWpiZm1MUUJ6ZE0yTnNza29hRkFVU1N1NVc5MkJHN0VjKzl6?=
 =?utf-8?B?ekNtNVNsYlRuOFBVRWE3MzR6K0lCZGZxU21MYmdHYmFyWjVFSzFiTlJ4NjJF?=
 =?utf-8?B?TkNrNDdhaXFHejlCUks2WU9XaWJoSTN1MjhoSFo3SGJ6ZExNa0Zpa0lEdmtl?=
 =?utf-8?B?ME1TSmVCamsrcmthOGR5Yyt2clVNRWNSOXduaXYrcjMxQ0JreDZudz09?=
X-Exchange-RoutingPolicyChecked:
	XlZsoWhLwpWXqTHyVkGIMzhJa8eDXen+rV6R9538fc4EH+EFOfOv9OBZnE2BZQ+/c6ZvXIbofv6f2fW7mzRAGp3aaNJePTetu9FYWwWuXt0rP2fFJ5I1UjDh3wWSH8ZOz1ENOXMeoQcYfIi0b27i77dt+wt2US/JXgezu0TwadBAbEGe6qSUkHueOS++WcYCgEKXivbxJqPse7USVRs7aqVRfb38JO1QW4ed2SY2qW97kFgY+lMEX7BU43TRFlx95UawRyKM1PJCXNk6Bj3wHG/FhW6nqZuIo2hsSDtjyDye5uiiQN6pJ/GoGH8Vzk2JNrYTQXOI9HJKNtYnGWaS+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ImdrensXpz/WH1FvBMQ7RwYnrgjNFsKRC1Av4mMIoGIZPhpca+7ceeZowWXd8PnAhZnalXc373v6JK/InYrvAr+De9AYtKB2j3qg0eAapFGOMGMQEB+OMpx47/zsnffAL4g4CEOs3LS3KYfHaZMRXRcJCpxYL5t/03ZtozRdZzo6saWCUSAk7t0DxKbKHazJw2Tf2QhN3zZmLTOS1mIOv5UgfJs0tOZ3pvlvRVMoXN6sJ2zETPbnFKp9n4yVfdqfcP0nNd5xTqIeq3N04GjjrxnQDsLZDrsSSl0/kP5Pcmq4B1IdwLyIa6QPVcj95tRJu0JEzi87KJJYKN7V1TRT/c7sOOsp/71wRuIs3PY48NPby7eHH6R7OgJlKTjOnGhIs2+QFZ77AMy+Qbefq+pTEYXPXMh7Bsh3prLYxbSk76h75OopFotv6uFLVCFHb8oZuZ2uIlB7PO0DWTD83McTd85t/hU2Dzf4upxoQMxTDvEEx/BNG+rtBTj/Oa97x0JDyxPdra2ULOiczRYY8Z3yxLykOs2KlhkTeINX33AMXk+kYAbHGKuaKRKXVHszadAjYvqc0kcnpzh6c0nJi0TRKj+MEA2VAe/jrN+GPY8d24A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d690341-e279-421e-15c8-08deafa41a28
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:27:28.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgkhA7k/JI8pKlFWDXm2uaLFlnA6jamzS5Eu6JUxyQK/IRSGE27/OBXE7uC/WIEqXGDDxbe1jjE7+eaUSg3O8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67E073224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605050000 definitions=main-2605110227
X-Proofpoint-GUID: cNB7jzedT_UJEzg7AXFa_bngapdaYoOe
X-Authority-Analysis: v=2.4 cv=ed0NubEH c=1 sm=1 tr=0 ts=6a0249c6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=JfrnYn6hAAAA:8
 a=vtsZV_TltIVkycOT-5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12299
X-Proofpoint-ORIG-GUID: cNB7jzedT_UJEzg7AXFa_bngapdaYoOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIyNyBTYWx0ZWRfX+bNSd8DGMble
 dihb9zH2v0tnPkyN3ZTEu2haa4zPKpGwd7lT8TuoTdaex+XoDrTIb+l8cgt+r7Ozj5qMwtUpVRU
 F0uLkYdJ/t2QhocPzkZQi/2sqNqWCysYf3uQSob9a2I5uMvnMvSAm9TQfAT/wey24jjlWL0D1Vr
 y8DCEOLIXskSTpCgsOqhJlr71BzmBBpd0SvIT0PvVZIs5E+9uG4pfLCXBxwZKkP117V1INcoSrt
 wOU64CWgc9UuF4RweRHssHtjMYc3v7//oqSdeR3kaUwcMDBTjCC4eUeKR++dChZSONs/xvlfbcA
 csQrEr8wW9KXHrseTOJBQalxwLfNNXAqa1lfGP4ZCCgmrkF9sJhZhyM2z6SefbAEk2LVdL+99Q1
 EXXWECVRlZt3yQweDbWwKhmtOfN9H9LQrA1sMUoRKChbPJly1JzUWZiSpklLE7yhr5z/WFivF+T
 H784OdBsWHxMsiPFrK4sRnh2aCT9zaVFHUJRAMYU=



On 5/10/26 11:40 AM, David Woodhouse wrote:
> On Sun, 2026-05-10 at 18:09 +0100, David Woodhouse wrote:
>> On Fri, 2026-05-08 at 15:40 -0700, Sean Christopherson wrote:
>>> On Mon, May 04, 2026, Dongli Zhang wrote:
>>>> KVM does not support vCPU hotplug. When a vCPU is removed, its
>>>> corresponding data structures are not freed by KVM. Instead, QEMU destroys
>>>> only the userspace state and the vCPU thread, while the KVM vCPU fd remains
>>>> open and parked in QEMU.
>>>>
>>>> As a result, vcpu->arch.st.last_steal is not reset.
>>>>
>>>> If the same vCPU is later re-created by QEMU, last_steal retains its old
>>>> value, while current->sched_info.run_delay starts from zero since a new
>>>> vCPU thread is created. This causes
>>>> current->sched_info.run_delay - vcpu->arch.st.last_steal to produce a
>>>> large, bogus value.
>>>>
>>>> Fix this by resetting vcpu->arch.st.last_steal to
>>>> current->sched_info.run_delay when KVM steal time is enabled.
>>>
>>> This is quite arbitrary.  E.g. if userspace hands the vCPU off to a different
>>> task without going through QEMU's hotplug dance, then current->sched_info.run_delay
>>> will also change.
>>>
>>> Shouldn't x86 hook kvm_arch_vcpu_run_pid_change() and reset last_steal in there?
>>
>> I'd like to be sure that we get this right for live update and live migration.
>>
>> I think we *do* get it right for the Xen runstate info...
> 
> Since I'm adding selftests to my kvmclock branch today... I now *know*
> this to be true :)
> 
> 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=d667349116
> 
> Looks like Sean is right about the pid change though.

Thank you very much for reminder! Base on my understanding of source code, the
delta between vcpu->arch.st.last_steal and current->sched_info.run_delay (new
thread) won't account downtime if we handle it properly in
kvm_arch_vcpu_run_pid_change(). I may also add that validation to the selftest.

Thank you very much!

Dongli Zhang
