Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B7383C96;
	Wed, 23 Sep 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184372; cv=fail; b=ZfZU5n/PJf5sNUigL3BLP1vkT7HNxZmSAQIEv+4Q6iPG5Bb/Fb+gSfsVnPBS1wrn/MAgIp4neREY/mPWM5lEzafXE+9FxYUSO7H6mvOZGRzPMrK6KAvS3+XvdEYaPMtcx5GXe3W661Z7PDxp4vSzRN6g++jB0H9UedgmVBpFCf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184372; c=relaxed/simple;
	bh=z8jqCNW7OlgJlptdqfMlccH6zvvQK/3N0sA9PqJO2eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eddj4tk5xUovBXwGjAr52IarwA10LRhXRbGEq/2rtj/8ulb3BG7HA28SRHLjCWR7zBkg/6nm5Eb+ziFAlW3D1gYxJJ8NmawGiIiNv86DNqvlC+m0ci/nyC0SPxPubTG9Wy+uywqd12zzegIwjkuC1DG4jiXyltjdz1BG5BOPo9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fjQxQZ/r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LLZ4IWG7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fjQxQZ/r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LLZ4IWG7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NErt1E2391957;
	Wed, 23 Sep 2026 17:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bzeFiOyIyT8zYtgtmYcxL7TwHu2PZS4CR44T5EF94j0=; b=
	fjQxQZ/rP4dC8goPIuzPfvxR7lf2xVg8PGx6ocFSJVxhFPi/jWypy3CITjGdrVdv
	SQhWG3lbgOYgA3UDWcwRx3KfKRDhfnqECtyw9Zyekr7cF1rZsrLKgxFpxKDjBQOs
	JCYRk+I07TAaXGbgbIQa1jRbwA3bAxMgm245Mci86snype62f4vuUlXLqrL8iE8y
	ozz2FDPOsmagmAFDBPeE4SBX49zqdk1BCA2VXCmlJuULzH7yqo3HTtlKz5oBgtX+
	P2Dwik6mEGUbqX5BIPjXMfqILXjUBUUKJRsiCrhCgSUbFxiLspSglOErPwZXT6/6
	jGBIEEzb0/xbLgGn149Dwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1ge85m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 17:25:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68NHKPpw038281;
	Wed, 23 Sep 2026 17:25:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gu1rc0ymm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Sep 2026 17:25:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIjS+jL1RS0RiTw1qjxoPJ3wWB4fH50DhoTFk/4SdWpONpcS0ABOtInfZA0JnVAbs5lsT/MoEBHCR35WEwD+cuiJzgYN/68MoI4+WbN0HQ20q4OLvQI/XuBU/cnWBZlSfkwnaAedFwqmEytLghsIC2hxVjD56dLFG67F6LEVdDOsGu5m+ng9LXzJCuPrZCVT7vv1J4a0ez756zkP/xq1zYGCaTjE9ZW2e0qaMf+M6qqGCaFgG5rl3v6VFJlndGEN6VSbvcpiV2JBh2J2Wt0lfJglj6tXy2HOIYjfhL0w1Pz6rD/oinNNCHcorCiZuXCjTFD/y0uK4ql/eJD4j5PnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzeFiOyIyT8zYtgtmYcxL7TwHu2PZS4CR44T5EF94j0=;
 b=gTkj2kjZ/geIgnCrqDcMHOD+9uvB59KSXHEg4AwH121uKJa6aX8HdQYnAm4WotqkiXNFGGWpCPNzqYm5/TCT7tqb9esKzmAbbLkjKKHjAbju3idQVONfNjylfQl9gXlmbTFHFZ5mNsXrf/Jn8+YoZXkVzWdpfU8mjn6a0BxW/A+nL4nlnv6BZ2G2oYlnWHb5OnUhaoJT1hojCpg3yHDNXI4lefqTtFRbHHhrELo4TsTLbZ8k5pSWkb7oT5H/VzxOYVrAOxzTBnXjPKOtlQhffNfv8BTTd2UfbH2r124mDVU6fkzumkn/RO8xpWWnNJPvalLqqv5nzeoQsF2/jurJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzeFiOyIyT8zYtgtmYcxL7TwHu2PZS4CR44T5EF94j0=;
 b=LLZ4IWG7BoOsTUcQWRPudJFpGuodYOezEqvtpGgPGz3kOyhSSRFbnvx3wpKzUF4cSgGtpoArfZJdWKrOvk1RI+SZD3DFKnzyZmzVR3MTQCd/RBLTbaOpsIkAfUpAY75k3dulXA/RqG5wDZLAbHt7xNkks7A3LDWljpnkZuJWm1s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by CH4PR10MB8075.namprd10.prod.outlook.com (2603:10b6:610:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:25:31 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0451.004; Wed, 23 Sep 2026
 17:25:31 +0000
Message-ID: <02e6b16a-67d0-439e-868b-435fe1c38400@oracle.com>
Date: Wed, 23 Sep 2026 10:25:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] sched/core: Defer preempted remote vCPU task
 clock updates
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, dwmw2@infradead.org,
        joe.jin@oracle.com
References: <20260824012716.753022-1-dongli.zhang@oracle.com>
 <20260824012716.753022-3-dongli.zhang@oracle.com>
 <arFUTBLuLdVVaqxX@google.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <arFUTBLuLdVVaqxX@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::24) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|CH4PR10MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f12aca2-d626-4622-e0fd-08df1997ab06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ve4TmZlRPAuKUZAI7r4VmqQtC3ccoCoC8rqSORx+2XO8aHOc5U48Q3fPOrgWLukU10QTuAx1L4ph9ammG4ywW64H5+JZ+JhfTJOxnCJzm1IJgjkqGg4F6hiMrDepacdYY5SWywRNEITQzrQSRLYd3mYbxNIgQqDGjARo1JSinU8Eao//wRqzLI5bPm0v7YUfLY1kz3H368xgTwc5MH5BPU5pD22rnWJRCOLSwc9puYXcAaoLRmw7HVElxqdFHpqtaVrJy3sdlCwU3GCKvBPZfY0wI/5fzvNwTr/7rOpsBR6P2ZfSKCCeXfCsRRYUcB2dXnuPw1WBGjv3g3pATqkGW+LsiVohEHVtcwYeYc5MXAlOHq9EBDExnBOPLaGXoVaYGGqPXTv5NRO1wzDgQpEdJ3qagO6iNmYHQDdtlS6rFKyxKGpNGcam+ppar14275AuBXxbnO4zaE2/2cWfn2/5fzPz8WqxyWTD+h4/fOHOV8O/arZy8evXVRnDOnDL0w6haX2ETn3xeLvSmyE2DP6AumtAMqddkHHmk0e0CCzwlncqu9Eo0tFDlre5yeqjdCBvVwOlSQHTCXZSBPReDFLwA8wp6dPniuNb/KMQdCdRvnNNygZAFBsUAgpP/WtzzPjxhWQeZjtpe0fGIN7kbOL+s9Ljlo5CPh5fqOh9eB5gDw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1djc2U2ODc5REJHTzh2TmgxZmVZYXhBRENTNFA3ZjE0cy9pS3dHTEloTGVi?=
 =?utf-8?B?bnlSNi9idjloTC9reUh3V0lpZjdQdGFrbVJ4WldwK0NRQVNlS1J5V3B0dXFQ?=
 =?utf-8?B?aUNPenFPUEJXa1BzWGlyY2xTb1RkcUFzcUg0U1cxVXNaRFlVODlWWXc0aENJ?=
 =?utf-8?B?dWtHVy9hNVZFUW1sdm4rcE5BMVowZUoxZ21ZSC9iMmZlZWxKZWNPbVdWaDZ3?=
 =?utf-8?B?NEpuTkNERG5McHBuVHVockhnSWlLcS9HTGlzUStNMHFYSFBMWldDUXNNSDRq?=
 =?utf-8?B?aDNkRmpBQ2ZjQU4wTEFNbW4rS1ljclAvaE5wck5jR3VSNVlwUThVNkdQdGlS?=
 =?utf-8?B?YlEzTlloV2kzK2xIZlVXdHZKalFjam1LRDdVeHpvTndKVUt4R05XNU9LZ1ha?=
 =?utf-8?B?bzNDRDFFMXhmYU5wWThxekgrYS94bEd2Zm9YOTlLOXlSSFBIUkJTZUpHeDhy?=
 =?utf-8?B?MWxIVlVRaWpzWU53Nk9IL2syS0dabWxYL256V3dnR21MRnkzdEYyZTR4Q1ly?=
 =?utf-8?B?UHU5NGhJUkhGZ1F2c2lGclNKN1RzMmFIeitLN01BUjhGKzkwc0k1bWc5aVFo?=
 =?utf-8?B?Ni9jSnpRSnlUdG5QUmJvcWhaZ285Rm90Tm8wMjYzREhtUXNCaFRQMDlRSFRT?=
 =?utf-8?B?bzhGS0JRdDlud1lqVjlJNmpJVnQ3T0RyNmhoMEx0cEk5YWMyenUzVTlaVzhW?=
 =?utf-8?B?NUNGOHpEcXlkdGVNQXBTZUdqNkQyV2d2NWxtK1NVMG54OEc5a21QanpRNFU2?=
 =?utf-8?B?cTc2T2FtTlZsL3NiaG5nN2JXQ01CTzRMZXhOL3FNcE1wTXBaWldnblhmdDVq?=
 =?utf-8?B?ZkVCOFRxY3dIQ3VNNkYreEcvWlVoWjdiWU54Zmk1bnF3aXdzS3VZNC9YUnM0?=
 =?utf-8?B?a2RTYW1LRnQxZXY3V2pocjM0RENxN051bjVTM3l0QmVNVTN6ZFJ0VndvbVk4?=
 =?utf-8?B?WENxMlppNWZiUThYaGpZT0dZU1JEZ0htSWZJWjJLaitGSjl6TklzOHloS2Zn?=
 =?utf-8?B?eUplZmFLRUNoRnk2QnFFZUNnUTZ5NjdyYkRyU3VDUjBYMWtkVG5kMlB6RmFL?=
 =?utf-8?B?M0U0ZmdRVXZwT3ZKK3ppMkNlZEE0VS9sK3NHMHltaEdWVDhPT0xTbHBVUSsr?=
 =?utf-8?B?M0NISmszNGNrK21zamgzeGtwK3lJTWNuV2c1RUhBNWFkc0ZhK3A2UFptQ251?=
 =?utf-8?B?VDM0VHZzMldPYXNYbWZlWjhsa2taNGZ0dXpVNi9oSzh5MU1RcDV2MlFRWFJ2?=
 =?utf-8?B?cVo4dVNVTHg5Z3h4SWZSNUJtSTVJa0xPL0tTeXR3MkdRanhicHprcm9mZ0J3?=
 =?utf-8?B?eDZKRVdHblRKOUlnc3FIaWFkZFBFMGpCbU13emdqWEUxSkw4TFo3TVgvbEVt?=
 =?utf-8?B?bkEvalNTNFF5a293eE5vdkxaWjV3aklZbHpwbEtxY1g3eWdjYkVmL1ZLTzY0?=
 =?utf-8?B?bTlkWXZsSDRHR0RxRmlIUUlZNXZNbTVocERUWmVGeU80Z25rNWJsYUErMVRz?=
 =?utf-8?B?Y0MwbGVIVUpHZi9PMWdqRlJCNjZkQ01qWk9Sd0NjNXFNZTFLZ0ozd3I2eVRw?=
 =?utf-8?B?eXJiTHVsdjkvL3hhOFRPUnkrZExjQ3ZFc2psbmVteWRlUE1zZXZWRzkreTBK?=
 =?utf-8?B?RWdOSlJvWS9ZcklIa21JZGZFMDlTVlY5ZE9QYU5KajRFczBIWjdDOVJwSlV1?=
 =?utf-8?B?ci9SYm1icVlaWlBHWk9qNGwzdmt2NlVIYzNlNy9BOXROR3RGaFV5QW0vWHZJ?=
 =?utf-8?B?M2Z2elpVUjZ6UkFoV01ta3pBY3FTUU1IMEdOM2NueEpSSVJRRnRUWEo0UUhI?=
 =?utf-8?B?Zm9GdVB6L1ZCT3YrbCt4L2Y0UEUzaHh2QllVOGh4MkxxR0FsQU9xdytna1hq?=
 =?utf-8?B?bWNmUDFhTkJkTGxqUnhHY2NUbWpSWDZ5N1Bob3dEamVBZVBxd0FaYmFqYXBo?=
 =?utf-8?B?N3lOOUJSZWJBc1NRVit5c1RoUnpLN2pqWEg1YlRzTGFnWjB0MTZmbExYaHYw?=
 =?utf-8?B?WTdlaHpqMUV2ZzRJVkhiOGFaZitlUHAzSW84VVdpdnVsbVJuZ1NRQ3R3azJF?=
 =?utf-8?B?Y1dRSm0rRTYrcUxOeEZVQlpSRG9naW5EQkp6T3UzVEJDWkVSMGxhT1BCRU0z?=
 =?utf-8?B?L3dYUVFsZjA0Y2l4OTQ2bnRMYmd1c0ZWbVJ4TTJZUzlYbDZRZm1aQTNYamdJ?=
 =?utf-8?B?YnlVS2tUUitzMUFmUTdtb2xBdWhabU9Fd1JPODZmUlh4ZWR2QkJic2RZT1VF?=
 =?utf-8?B?dmg1QXNBU2RIQkNGdzArNEJiajRtbkxKKzFhVnVPbHBNOFVIeDlkOEo0SW9o?=
 =?utf-8?B?a0d2Q3lza0pmRmM2QVl6cHpWclpZNmxwanFUaGxiZCtoR0l2KzRRQT09?=
X-Exchange-RoutingPolicyChecked:
	QljQBZziOzhY5VNH3rW1TLnrJ9xoaIUFOB1JT1DWqydpNN3P7jQxFMLjThgfVKfpAOKtFGa3oeWQ4oqUK3F8/Ysl+nvM12bAQFdP74agrd483JSIChSb1TaNrU2tJ5fnezzdyIEdkaJ/fMnp+AA8jbSlGJfC7ilgQMsA7WZcwZ6GVSdHlOqX5op6AQtTRMBdAuFZgK6v65RfUQM1BBKsAGDXDc75QTWec5iWLu0I9aeVk7vsOjQrMsnRI2iToVeBQR4zI9Ii+q1pnTzE6xQ5VVccCjs9o9bXe5aPrE6/e2YQywMSvKSVdUrK18uv581dxo8RAYtmDdb9j2LyUtq2gQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	28ogo6TsIlBFNrDhcoROSxv4zEPjgwMUBmIwdtBkYD/BGSYcVLOzR9NquTbMQxMSu9tH2g7JjEvSatGAeEw2P/svVl9Kxdz1neOJoW78B5CS7w3HzNJ7fsPpMtjKbsj2QjgnY33r3YE0YJxf5B4kpa0vtOvOPPHOnAHbI4QIwlKXnXf5rAQbfB+7GbBmLM+F7AIZKbN7WDX+mvLMaByt8tPq9xpqs6N81Iw3z7XdwaUupQWXMtHySmkHEYObqTB3+NijYFMDQ5JBa7MParmW8P/zDOSd96OCLHJ0doDuC9Y9nOnd0ZKh3loqhrLtbS5VE9zMGKgNCeEE0bP22yqKsmTq6I59GZP/VIxDGNyDKRHCqJl7Fbsbg56eWgrVXv5hVkpPyTrjaKc+011xOFZkLq+PIc4P/EkVuTeYNDcYwVgYfyLzTWPaHLMFOXvgXnzuT9y4kOLU3WQ+K41PKvH9NNXO5KoNk15gME91hzoIdT9QkzgvE0jx2BsdvghqdW/fHrPQI+CJ3oT7MGSqMEA4JWTHGd249vIpSLF9AbjCEqsdMYhSfkTts6SadW2gFKyyBiOZMQQgDt5ixTLXYl6Egezdf5tDSMOLVu5tIO/+tSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f12aca2-d626-4622-e0fd-08df1997ab06
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:25:31.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8VFXF5CpwEjRIbBJyfh29626AYzsEO4eM1xnWM6AbkJK59rF0gocPneTq+26xB843giVL0/FNEmk8CsbmlwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609230069
X-Proofpoint-GUID: CKGFUIlnROEN_Xe_MbQQvTuYYrUBf-1n
X-Authority-Analysis: v=2.4 cv=T6sZ3PKQ c=1 sm=1 tr=0 ts=6ab40b92 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=-ACe4YRWzawKTbou7kUA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OSBTYWx0ZWRfX8yDs4LFkKvcL
 OxAZglJeyDiLHKs7MSBWRsk4GvO+wQ672rSIH0NoPTIsCpycC15JFo5q38KKRFx7/rco/Ps7Py8
 yhhP2z5h/uy0n720+5/olXRH6ip1ZeoGJ7CyGg0vTHaPE2fOlBLt
X-Proofpoint-ORIG-GUID: CKGFUIlnROEN_Xe_MbQQvTuYYrUBf-1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OSBTYWx0ZWRfX2IaQc5Xlk5S/
 Pzzzd8KZ/Rjpma4coQCsmHUkq0L48l3nALfrlljehIUXLSCOnlvR3Dpa1psIzFL3SewAnYbAXsX
 OYDrL9ldI4hKiqzuAcLmk97dh6NRypHOxB2lOrNjrLkLzINWtUKDCmRJi/v4nPYFiHlNJrA5Y8l
 TEEAJGlz+4bkQUg2DniLrOWyECbhCP9+kUs63EF7HPZOn3rtlTfuCDf0J8cuOz48pIvR4oMyFX0
 Emvu8h3iqfW3KXsSH0ZuoowpLE89zCxvfjLe6suumQLS+E1wBj+hFqmoBgDqSBPsW8SQ8BNwyWB
 Bq7g9pTtjtt4D1VhS33NrIPoprU2XToHXYU/At9FNrMq12SU1VqGFMOyJemMXyGpTeirahd3JPU
 yquXOlpipYOeHT4BN3opI/B7qej2iC21wwZCPQQyJlZC7qvAyEBHxCad+CsTdRkLRFCQDnBg5fp
 9rgVGKJvYKMnVyy8W3ePcEtQruQ1iNN5Y16z9X1I=



On Mon, Sep 21, 2026 8:59:08AM -0700, Sean Christopherson wrote:
> On Sun, Aug 23, 2026, Dongli Zhang wrote:
>> A remote update of a runqueue can advance rq->clock while the owner
>> vCPU is still preempted by the host. KVM publishes the matching stealtime
>> when the vCPU is about to re-enter the guest, so the remote CPU can
>> otherwise charge the stolen interval to rq->clock_task.
>> 
>> Defer clock_task updates made by a remote CPU while the owner vCPU is
>> reported preempted. Fold the deferred delta back into the next update
>> that can proceed so IRQ and steal accounting process it together.
>> 
>> This requires the hypervisor to publish up-to-date stealtime before
>> clearing the preempted data.
> 
> What happens if the hypervisor doesn't do that?  Because it's infeasible to
> guarantee this will never run on an older version of KVM.
> 

With an older KVM, st->preempted can be cleared before the corresponding
stealtime update is published.

As a result, the guest can observe !vcpu_is_preempted() and consume the deferred
clock delta while still reading the old stealtime value. Thus, the stolen
interval is incorrectly charged to rq->clock_task in that update.

On the next update, the accumulated stealtime delta is observed, but it can be
larger than the new, small rq clock delta and is capped to that delta. Since
prev_steal_time_rq is nevertheless advanced to the new stealtime value, the
remaining stealtime is not accounted in later updates.

That's why I tagged this patchset as RFC, to seek feedback on whether there is a
better solution.

Thank you very much!

Dongli Zhang

