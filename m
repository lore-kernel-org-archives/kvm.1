Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA33AE706
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404250; cv=fail; b=KoGfUq3aNvEBECDJbIQdGY7xHO6bI8fxyplUsnRmF6AwUElUGIj14OpmbrZGmuWKBpvi1cNczZiF073TiuoDChQxYjzuGpfqqiUbSSW8q7374ex2w9AeXw97QQQH912Br/sCPDhq913iWKdiEVsFPhw9RWaip9t5n2Fj809u8cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404250; c=relaxed/simple;
	bh=mBH6l8l4vcs58JNQNEsm1i1l70Hzopm5lKkr+a3sBbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hntAist51QIXLArOFMLtoZn0IobssgfQ9go0eXzGYeEEisNp75o8ZyM8Zr6zneFFarPFBrk3/qsJwO0hOYD5W5qTgEvfYQtODfZDTkoRLsWi8bVeF21s5bQRZ/UHjiA7EDS5fwwXu4Ooi5HJH69+sGDZQNM7edrlyV60Orr4hqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CEbXvFgK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HRnag9yZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEbXvFgK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HRnag9yZ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFgAQU165277;
	Mon, 10 Aug 2026 23:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AcC3bTUBaaIwXH97LepWXXZzXsCKtK7cGhg+QvMQc7s=; b=
	CEbXvFgK/nQ9rCQA+hh7QWWE/ifgwis3GVU05sNMHJ4tK8Q3N7HJWT5XWUV+W7d3
	TeNk6Vd3wPfX9JStN9OzM4GcMBNPBVbfBSm7x1fuTaelENZpndDRj+/uJfna3nnN
	DLzQkBmXMHcxEKAizlzLqfdD5KBqs+r8ICjzjQq5ktNuqLZ61NLDctjAjPAtYAg6
	gF8hKM91kghqiZachCk1zihO9OjSI2PuJ5xoeHcYvIvIrtr/F4fyrbQq4WCabek8
	1wjvXzIehMay51jbya1XQul+tmzOJFLrpJzHtf0bn1EVBeCD5F45pyf3UyM3biLf
	rOCeCRyU7swFSU3UGEqzow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxuj5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 23:23:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67ANFWbD005115;
	Mon, 10 Aug 2026 23:23:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwqtxx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 23:23:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRvjR7LxdxBqweRdEi7rFJDhvtEd8o0X+YmVLBNvLDhvuw+PHZPgLmrtRAooDVRQdekgd0IjHtCPZdLuYFoqktD8AAqhcJQLArhQUIeF48QcL7xQ5PKX4FliyYytaviowUwft+Rd/5pHs+1gViEXjqmJI83sj0oRHcQ6bBXF368wKF5AamxSaAxiDqxYurAtdKPn16kJGa73lbZCz8i35uZujLlXkAmGuhz4/ylY5nnMIV69EO93yTnY83egJoyskmkf2KXhgM2e8CeLqouEFcv2dhlRirEGjNu4yyK3wlDWh4tAsLMwYjsMvQ0pvHm4TlFARWxArS1lyhzKW+1E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcC3bTUBaaIwXH97LepWXXZzXsCKtK7cGhg+QvMQc7s=;
 b=adG01WHGJtCyjXOUjYEvg1OxD2yFpN4+7C9oe2Ycm2iNTYtcSpBaGg/1BMO5ASE2+X9tdJHdQJvSQ2H8sG5ltefNcJcyv2KWYrMlZTX/2udGJcZLJBvvkdVc2mpohIVdKB852tSR+19Xv4X+rsIb7GWWolPbE8YbkjPADLkv/IlF8ZqFWVMkE9HPvWzvLoxDTb5zqz+nETrt6P5XpIr5Czx+7VoMOIa3GV+0PvarKBUsuPHeCb0EZoFBG2dM8Ky5BvWhTOkJHXR8fwSmDFPMLrDhKmTPwZDmdwNESoARLI8VEs4uaR7ort+GaChsCkpv90vRYw2nJJnno8ajI5jsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcC3bTUBaaIwXH97LepWXXZzXsCKtK7cGhg+QvMQc7s=;
 b=HRnag9yZMQoCAoJ674dZNQcM/Z1ItlTAUCAOolAJDf7ucRN1sBgkXr+xf87GnOmVoBbmQ9FgvThH9Rj9iUEvmTrOp5NcnP7mU9Snv/R2cf/gOHzzCe2g8F2uKDFkpIOXS3T5KQ7TPpSsLH98Uqv67HrMEfFI0FRa899HNpvVwbY=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by DS4PPFAFF9EAD68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 23:23:49 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 23:23:49 +0000
Message-ID: <6a14bfe7-c8cf-4329-85c6-480781355c41@oracle.com>
Date: Mon, 10 Aug 2026 16:23:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
To: pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mtosatti@redhat.com, dapeng1.mi@linux.intel.com,
        sandipan.das@amd.com, zide.chen@intel.com, joe.jin@oracle.com,
        qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
 <aigek5eqJr6DHZau@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aigek5eqJr6DHZau@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::18) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|DS4PPFAFF9EAD68:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f914923-bab2-44c3-bf1f-08def7366e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J20v4+O+YDxIICZJUpFCEogITDsiub7cwTxx5/aZLnS38zXDwmzDHytDyF1un7XiwP0/KKQIBRfgbcFWHiMgl2plB5dMLjLRoTwM3411YPjMJryB/XziLjfLbknKFhVS+YtACObcxY/OuPIZv/f/Ap0Lr773T3Uwqqwu4OlfNplbTzoXDpODx68VUe5I50J4C4PZI3Ib9LTXjVEmSEUH/F5jFcUSAkryI4fyg16E/JwLbgmsQ7VJW2pffkTl1NoHTcqQzmzYdAdSObo3gBwJD+01Zesr0VVQiRkn0MKZA5Tcr4hPgpLIQ5xbFyp+2B1quk3oQLX6Y0LTttUhgsHtpE4COgdnd7AM5xldYutYU7ZiypL5TfvK5fhjDP+cV8tApZHG4DYAD934r2F8fffaw+G92aqH8PXk49IKlRo0DAgWhUVhJBEPGIuSCWpsizv6FJFLT7GWLSFZpO5N0269J4mJ+XAKCjwIFU/1+EYqVhRjg8rA8CdUCY3rDJnpqWCpAHC5bVkY92H7fwLuk09fpnMZ+o2OifBfbjW5gJsdgkEtNbds0Z7EJ4OZSPFxzxnNjiF2XgGYmdMrDvAZFlvoqaSLpcbU9r8nio6zYer2UuKZ2uLyq4UAa3iLX+B3JTYyKm7ZcnHFZ0OnyXKOa2uXBavvVUxkzfjfY+UUx2v5Ci0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9jZ25EaVhCUFp1aEl6UnRrM2tlUEt5VExDQ2F6THpISmpXYnlaSS9mdGlk?=
 =?utf-8?B?MVdVaVhGWjN3ZDQ0RGtkcGw2UVJ3L2tYNWp5alhvMXBBSjhCelFpYTRMOTQr?=
 =?utf-8?B?dUpRNUdwTEJHWTVXdzVnTXdEYkRXZTUxelBLZVcyTDJHcCt6R0tMU3RqTDkz?=
 =?utf-8?B?QmEvNDdvakxVa0FkZTZQVC8zT0dpaERiblZtM041MlVoVWIrdm1QSnVmOEZV?=
 =?utf-8?B?eFBadit1aWNBQ2RWZ3ZseFJqNjk4SVFUM1d5bWtHam9MaW1PQ3VUNVVGY0Ux?=
 =?utf-8?B?UVNCQW1QMlhQcVg4RGNyQXJrUHY2MzNobXdTeHBsNG5CTWgxbWJZd3FaR1Rn?=
 =?utf-8?B?MENXblNlVVhnZXJZaUVRbWJ5SlRZWE54Tk9ZZDc1S1FxRlN1ZWY5T0pRZDBU?=
 =?utf-8?B?aFY0MUZLYzU3NmNqZkVGais3cVBZd05IelBkY1ZaVmpaQ1oxMGNlNzJrWnN3?=
 =?utf-8?B?b09OUTByN2xiWTB2MHlVZUZJN0tWemQxcTd0aGc3YnJkOUxmaVN1Q3BWUDRJ?=
 =?utf-8?B?YURDYUpRWEQ0WHZoUVZZazNqWC9lYWNEbFUyY21uUGtZY3p5UUt1eW0vOERo?=
 =?utf-8?B?b2sva2dqbHF1eEdXb3E2WFUrMW5MOHViQ0JOZmxCbU5Qa09LMTU2UG1ZOGdD?=
 =?utf-8?B?OWVjd1ZYVTFtR0MvdnpScUhwMStWQWNodTYrdkN6OTBLeUp5RFZleTV2YXBh?=
 =?utf-8?B?Sk9ab1diS3JLTTAxZWpsRHBTYzVra21Vc0ZXWTdHQ3NTOHd1eEdRcmpGa0o2?=
 =?utf-8?B?TXdyUEhTd2g5ZnVEWi8rdEkyRkFaNnl0bENLajRJYmpwaVc0a01keHlCQ0Er?=
 =?utf-8?B?aGY5YjJ2c056aUpDMUs5WXVKMC9oSXFCcUgzN2hiZ1lBVHlvTnlocEgwMSs3?=
 =?utf-8?B?VlRnT1ZDTXdMay92S0lNTGhlSFNreHBCMzIyY3pDU0t6eExzd2VUWHVnUjJk?=
 =?utf-8?B?VUI0MXVsQ3hmcFcvdmVBWU5pWnA0WC8rUkM1R1RKa0ZKNUNhYURXa0VEUmE0?=
 =?utf-8?B?YmtTeG5kTGU3TzQzUGtVUVRFTDUwbmZGaGRwNkZ6YnpmZDFlUnF6bXRYUW13?=
 =?utf-8?B?VnhNOGpKUFFUNWpRRW9RbW1EQ0tGY0QrT2FUUW5yS1FsMm4vUjYrWEdqWGtQ?=
 =?utf-8?B?QVBDK2Y5cjgxVExRWCs2QjdZWk5PbXlnd0tSNHZUbk5BZy9XMUdwUjlzYnRv?=
 =?utf-8?B?L1RGOXk2ZWNSbGxsVnBacFdXcGExREdrUS9KbURnUlVqRFVZOUo4Mm93c21Z?=
 =?utf-8?B?azMyd0NKYmo0dG9PaDNUZW03Q1d0c3Y5dFRld3VNakFvY2VwR29CUDN0K05o?=
 =?utf-8?B?NXY2YmlsZ0dJbXhBYThXdWpOME5KMVhJN3RmQy9Ja3l5Ujl0NDJNSzZOMURp?=
 =?utf-8?B?bGF3RTZ4VWIwdVlvT0ZPN0E0UjZVaWQwblF5Y2NqVnNjMUJuSHZNdDA1Y2ZL?=
 =?utf-8?B?a0dvQ3pDMnlNSU9SL1VKT1piWW0xMWROeStmZXByWWhSNFZNR1NOWmZGOWVH?=
 =?utf-8?B?UGpzL3V1RVJyN2Z3NzZWTXlCNzFYTElxbDlDbTJUMUVYdVN6c3V6cjdUQ3pJ?=
 =?utf-8?B?aWhwc0Nxbi82R2pleFFxWkxheVF4Vm03TjRscUd4VEd6di81OTBxLzFSL1VS?=
 =?utf-8?B?MXE0K3lxWnVZYkpFVkxqTWI1cTNGOWJjcHpBTXpnWUNTKy9UV2EwVHE1ZThK?=
 =?utf-8?B?NEQwV3NUbHJvSWtkc1lKb1Y1dWJqVjVjSDdxb1AyMHFxR2d6ZHQ2Q01XQzdT?=
 =?utf-8?B?b21JNzA4NURaa082V2dWUlZuSzNlU2lYZTJPMmZucEtZZkozbTl2WlVmU0xh?=
 =?utf-8?B?WE5QWi9zZjZncW5vSE1VRGZXSy90YiszQzYyZkZ3US9xSEhqQm9vUTF4TkJ4?=
 =?utf-8?B?TGMvRUtSWkptNlZSdUcwUzZUQ1QxaHVkSUZvYWRkSHZ5UDQ0Wmd5MFJEZ1pw?=
 =?utf-8?B?Z0RuOFBpbi92TjdVeHV2VEVQZzZtK1lMMHNSTS9LZUpNNVFPNTlqSWYveEti?=
 =?utf-8?B?MGVqRTkrR1MvZDduSGhrWndHVlJyK3ZEbzArVGlmemc4MjJMZExKbjdrRUE1?=
 =?utf-8?B?cEk0TnE1V1JkaWwyamNmODdDOXZWc3phMW9kNS9pRVp2Z3RXOEJDZzNiYm9o?=
 =?utf-8?B?dHVkQjNsQlhxb3JRMkZZWTNlbDNidEQzNWZpU2VpQTlBcm9MNHNHUjBYSEEv?=
 =?utf-8?B?YmVoaXAwZDJSNGRqR2VSalJ1NWs2dTNFNWhqUDJIWFZ6ZzVCdzBoR1doTExW?=
 =?utf-8?B?YTNNelMxS1pQRDNCbzVzMXlRb3RTSUZTTzBMdE9zaDBrai9jRG1jVUFmZUNt?=
 =?utf-8?B?aEQ4WVJmOU5JaHFtNGptaTVkK2VVL3ltM0Y2dVQ1ZzY4TWpnV1NvQT09?=
X-Exchange-RoutingPolicyChecked:
	Mb+IbyHjs+71dtfT4UaDZJ5G3/brQMUtum/V7P53dyWUky6Bf4GpsU5x9wwXzA2TSKgPvryoOJb/VTS0X7DOpYbfixDEsu1lU+4O6B9RHgpN6DKZgWlYLLm82UenCRXb4pqJpVSvFQvx6EoyvbJ0bmbFBoTGl0CLp8/l80xQnFvuXgXWRclMQ5bsp0NkDlK4n13jdJln0mSCe3q3AbYQznZgXQquo4nUIrtf+M85KcVchcaxWNYwrxvE3QTT5CYAheFpeR94VsXwGzR0C7p0cLGK2lr5rvby++gedvTrDL25Z1OS1j/bLVZUbZsXN35EdR5qN2ma1PUzcfSlfwzuEw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SPz+bbnvsOWWBB0AarDDJKl7FnEk3NPOZzsakf/46ijw9rPxPOQbE/00yEWapfRVJF3xElKHmE/EXwxPvh3GWCa1o0joKhYeIXXfheWvMTWQpcWeIx3YPC8rbDSv0Q+mjOw1pg91LYEi4Opdsx1PClj5N5TJz8hePHhvBjlfc3qeYjVwFF8naIyVqFnXvfWvWA9UXpVUR+YvOiSvLagfvkhdqb9t/JF9uEP5nNPdrD+D9ecSiMG97WhMIw0xf7PD/IWxjL9ll7iebcDsAUhgr7d02hxJcAWQD89wa1Y6Ot4J5g1DjQUHNKrZYwaIdvz9dlmXuGYzKHwplDXSaTGyoUKOtOjqeq326r7LifdBhyxDz0rBQKvH2oA4Yry1ddQPHwpUtfPMLmVOeUlPYr0ZiopBRLsJwhQXdI7OuRPIV/9kzcIeSkSPINUe1hAVSkUf7NBjOnP1yiRFuCwDsXu1HK3pInroH3DFhblqaG5I/w7qVkN8yIAP/ujaTi5HfXUjAPhadXqxFvK+4AAeJviDUMHrK+gE3EJzMoO3q8+qeIeoDsMJAz8NgYox++2nCCLsi4989bMNPnmLopLovsTH1ohFAQ+R+aJfdKGlZt2HJHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f914923-bab2-44c3-bf1f-08def7366e98
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 23:23:49.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DATM1EoX1gtk8Hw5k+80x5UZiKr8PGkioPKs6sZ9CNafFOTqtpCmRtRccvu6EqFEV27k3dnIvsSbEomgz1lBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAFF9EAD68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100198
X-Proofpoint-GUID: 6yBJ-U0yrH-wC6j3uKvbYDgdCyzFqmes
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7a5d89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=69wJf7TsAAAA:8
 a=TJD7A3fHtCaaXPdfes4A:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13509
X-Proofpoint-ORIG-GUID: 6yBJ-U0yrH-wC6j3uKvbYDgdCyzFqmes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE5OSBTYWx0ZWRfX7bpyxVPgrLBS
 /Ot5KVMUtTcje1PqorhrJ5Gsu78u5B5p4bvlYswGTcrAyuTGBzGxa1osUqcRiNmDEngELzkfARM
 XmG9sMTYao8g4Vnsb6LWbAyuZGnilA4EJtG0du2cMom0ZyVp3UQy5bRIis4lji+zO0v27bK7VP7
 49vkZN/r5TBpfbvzQ9MIQCm2kLQEsVXPAGH4QvrCHg32GdIXdlPRSPEFsEo7S690C8wBaFN65xx
 DQdqNTWMY+STuWD0sCs8GECPcIHUT0WOmSku9RyNBPsmi2kWjvYL3Ej4YZBiDT6FK4zWeCA6jQK
 +f558nTXxhpAl2dIFKzJzHmuNAhgtex+Z+LTrZAaz+1GdkvUrqC3ypCcEGBTVBRePFh0ieNNTDC
 aV/+EZA9PLIEQy1Ou+OaBJcMj59nOARAQOoK6U3P+4oA5GdE+YkwI9NXaJXiOQKhCMVk8ROSgWZ
 HlFzkK5vg3Smbpj0nBvD2oIMEb3yDFQf7SLwsp+k=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE5OSBTYWx0ZWRfX7CYvDD7+Od7x
 6VJHIRioxv+D4Bmy4gRPHiTQi0eR/Ue3s/XouOkG/nqa+W5R7eM2dpHd7h4pd+CZKSSpDWWLBUp
 c11/cEDzcDvSuZauOTbFCq31rZYsVgYvPEIAWReAkzHXD1tlVQG1

Hi Paolo,

Apologies for bothering you.

Would it be possible to merge this bugfix? It has already been reviewed by many
developers.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>

I have verified that it still applies cleanly to the latest mainline QEMU
commit.

[PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU getter
https://lore.kernel.org/qemu-devel/20260325021236.14574-1-dongli.zhang@oracle.com/

Live migration of AMD PMUs will not work correctly without this fix.

At the moment, there is no actual out-of-bounds memory access because
MAX_GP_COUNTERS is large enough. However, if MAX_GP_COUNTERS is reduced further
to fewer than 12 in the future, this could result in an out-of-bounds memory access.

Once the bugfix is merged, the upcoming v11.1.0 release will provide more
comprehensive and robust support for AMD PMU live migration.

Thank you very much!

Dongli Zhang


On 2026-06-09 7:09 AM, Zhao Liu wrote:
> Cc: qemu-stable@nongnu.org
> 
> On Tue, Mar 24, 2026 at 07:12:36PM -0700, Dongli Zhang wrote:
>> Date: Tue, 24 Mar 2026 19:12:36 -0700
>> From: Dongli Zhang <dongli.zhang@oracle.com>
>> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
>>  getter
>> X-Mailer: git-send-email 2.43.5
>>
>> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
>> behaves the same way when PerfCore is unavailable.
>>
>> However, once PerfCore is present, AMD PMU switches to an interleaved
>> layout in which selector and counter MSRs share a single alternating range.
>>
>> MSR_F15H_PERF_CTL0 = 0xc0010200
>> MSR_F15H_PERF_CTR0 = 0xc0010201
>> ... ...
>> ... ...
>> MSR_F15H_PERF_CTL5 = 0xc001020a
>> MSR_F15H_PERF_CTR5 = 0xc001020b
>>
>> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
>> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
>> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
>> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
>> counts and env->msr_gp_evtsel[] holds the selectors, so with the
>> interleaved layout we must translate the MSR address back to the logical
>> counter index instead of treating the interleaved slot as the array index.
>>
>> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
>> the end. And in the reset path QEMU simply zeroes everything, so that use
>> case still works.
>>
>> However, the live migration is broken. The PMU state is stored at the
>> wrong indices, so the destination VM reloads mismatched selector/counter
>> pairs. Fix the getter to use the logical counter index rather than the raw
>> interleaved offset.
>>
>> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  target/i386/kvm/kvm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Sorry for late response, LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 

