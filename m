Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779A218EBA
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148200; cv=fail; b=dgDoUNm98SRoUhw4atT3kWkTSaEexyJmVydInehHEXzThVI5itwgfm5v0aaxnJRA2IepNhNrsYoDRlNCG9yd0dKHypw28nMf8qOyVthG2gce0ZYz1Vl2VW8Def/roq4iIF8300eovm0ef6OsYNYS4qgyCwOHhLc8dQ2eUsT+5gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148200; c=relaxed/simple;
	bh=nco+i/UZ9BULrSWQnyapX+JUR8c1OR+2/S3hd2ntkOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2JMR6JV8doBqRX/RzEj5BhDcoPZFvLCtariHvpDk2hj01mW09rd8lfOb8GZW9+p8E/2sQ9M5AKa+vufTaNmNfErXQda/3Y69DSSn0nd4fqz9pNrkrF9WACykqHYlMeo1XqCMsmYYLpJej9PmDfldDB1ZrdfkQ7CNhmaATdlZms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lq+CjsL+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QZQEVyEj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lq+CjsL+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QZQEVyEj"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JDOGvs2967200;
	Wed, 19 Aug 2026 14:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CO8k6Qg5fNUjU0QTV/5Rbz4d0wV2H++TDPdXMbw7Mbs=; b=
	Lq+CjsL+soXq89bFJv8SuXDXW54etuxECYnisu/SCnC+yOE5ImLkn6i6TF87V+dz
	mK60vzruV3MaXA17FHziyqgXLxM0w+M0vEGSrGU3GU/n+eW+u8Lm04WPJGsbKzv6
	Zu8W3AcFDYrbkUlag6qxY9DYDOi4di3/jvirW6RTb+JAwKHTBNaTkQg+CjebwF+b
	t95FTUWkONXNu+OYwS8bHZXhnMkwDwwmrp4Xs0Fh5dS0i7luLx/oyLxf1arp/fCq
	xm3Ktw9cZli0vhSji9EEmS6T+M6eM7KOBzY4iTEVC6hFsYD876h/BIKAy9p8wziu
	eLAqzPMK7ed0kZgOlSkyHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd99e5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 14:03:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67JE0cst014361;
	Wed, 19 Aug 2026 14:03:05 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4g32hs1xbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Aug 2026 14:03:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5DOcOcnTJMFfFqb1XbtjZrBYzLsmp8hPCPB3hA7v2UkosFjwz8OOzZqR0eJuyBQROf3wtbKrIqKFCdVg9DNfdM86bPSt4wlDUVD9hplBpiUyf5CwYZv8klVmbeKkxtPvPqZVbvs3BjWMrrbgwNjgzcQFW0qUuBqIssvkk7B08pzVqR16JkjfhIjMA12dB5Z42H/36JX3FufCRueU11DZMT26YrdSZIFx0EziK9OSNQup53z2tmK7kyxA010wCGr51XD6y/Y47t7ADggUo4Zk1w8CqeOogXaV0V0J5/xFf4+38VJSnmRxfNwyxQ4/gOZJtfRQX9Ya15igmzZMzNPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO8k6Qg5fNUjU0QTV/5Rbz4d0wV2H++TDPdXMbw7Mbs=;
 b=tvme0i/P4P5ZxLwOZL2myMfi350R6YmH1E29H1KWIBy0e/WWfx6EAoIm2Br2w+tGmi1Mq4p+zxIEDpldJTuADoZnVDUoH0WLaPZ1n8BLqVBoM7UBISU/VsX8SBX+7a1wm5yc5bGJYtGtx0IFwoV4cn5qtpOaB6qqeztenscTQHPj+GQySJRU/f+GxSV8tJ9tfsha0uG35X8AHZc9Z7Jn1xgOR6zVuQ6eI5KiCrNipBEk6Yra0cgRUYcJtqIjBkXaRLglagWZz9KNNQBj1dxzH/+uXOTWTbMx1YLJftXy0ezn99scdGKNQoSZ3DHp/5Vq3tuhMIwuEzwsPJhcfHaFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO8k6Qg5fNUjU0QTV/5Rbz4d0wV2H++TDPdXMbw7Mbs=;
 b=QZQEVyEj4s9zPcs/EZ+u2U3O3jEK/IgFEva+jut1EYvh8AfTh0416ecc/jxZrRNZKKf6XXYIXXLrQ5TZcwrWWtCNGdXhwzPPog8nQ6PlewPEOfZC05kBUmPd1az/uZGnyiDF9989k6lhFm5NHClOxuo5e7izxQ9tD4vSQb8zVys=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:02:58 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:02:58 +0000
Message-ID: <ac24c392-c7bd-47dd-a055-ea5f46cbbca8@oracle.com>
Date: Wed, 19 Aug 2026 07:02:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID
 together
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
        joe.jin@oracle.com
References: <20260818234238.618158-1-dongli.zhang@oracle.com>
 <aoVDogaO_0IYZQwm@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aoVDogaO_0IYZQwm@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:510:2da::26) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a71a698-7e07-44fe-7b91-08defdfa932c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	+gE+rrTTj0TdMxAOjt4RMnr9dg0kXMpPUYFMcrhVzzvbu8NO8G0UejxFvQ9yXsrl2hX3ZilsVXWy1qQ1f9PK0i+XkPNIy2Ev0jhaVNNyVfeBGcXGkkIfTme/XmL9zoTZ8D9+I7VGA4+PERse3/8ZO9UxGDq9YTH2XeRotCTv6215JnrCAsFdryuMtQgcpM8Pufg+qmnR4Tqkq0BXZYeAFaQ0btbaV0kuLFBzAfBIYwktMKVD6NhfWKRCUeHwIRgFqPnage+fulyE5SHayc3plGO+qxTXwHUc4ustF/lvsHHwDcyRuly+nFXXAhbtYNyRhmPXrlWpSaHglqTxMK3Lk+/NZKLct5TPNwGiBKds31br1Bk4YRCudg6OvLsGWMqXq3h0UVrJxjPJggt+69usgukf+pVy6aifU7vFk3YXt/9duh1AcZbLAC2WHphcvU3Fif8/PaRKryPdQC3PuvXGzUctQMJmuYPjTC+YU4k9GIYbxXsdTSobFiZvIW8nPFnhk3C6nsehlJ5eMO/cAlmEkpXCeqWvnpsa4GS6BifJFmye4f2N3QL4miP3GFfhbuJDXWjIAA0743AZ23fdsc6271a+Sa3mHWIBU51PbDf4fHbryaUmI6ahh00v1N0KwHdyaDFYz+VqqOXIoz2OyZ4GXVzkQsQuZO5lhDmoicgOufY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnc2dEpFazB1OVcvUGtMRWkvY05BdVVSQlZzYWQrbFFxOHZOQWFuTEhHUklU?=
 =?utf-8?B?VDVXYzhtMWQvd2dHSzlBYjJQbHc4aktWQWtGS3ZOYnVSZlNCazR0b21WYWJI?=
 =?utf-8?B?WlZ1Mmk3K0QrZVFOZVVuMHZSbWs0dXo1ZnFJN2pldWx5V29zVk9raTJvSEJ1?=
 =?utf-8?B?OGg0WHdjMmEzdnFxUEFRTm11SWtZV3NtdEdmL2JveWF4Y2p5d3hROWRXWkx3?=
 =?utf-8?B?QlVyYXJuNHdLQVR2ZHFWWUN4OW5zNVAraXMvb3FhWHo3R29lbWIrYmxNTzNN?=
 =?utf-8?B?WEh4TlViRUI3SkJBU2NQZkxJZ0xjUklsUGR6TjRhODZ1SUt2LzI3RkRDRjJo?=
 =?utf-8?B?bW1XVEdmQ2NOZnMxTmhBZUtGRkw0R2FiNlJQQWJmRjRMb2xDcUpxL0NwTzBm?=
 =?utf-8?B?VU9VdWM4eTlUZHkxUFZhVFFCWXhCRzMxUDNxL2dhaGh2QWppZjE4NTFFR1J0?=
 =?utf-8?B?bVY1ek93MElwNUNZUlVISEg4L1E5RUZBbWUwdnBsMlB1OVNvdkRuTE1TOHMz?=
 =?utf-8?B?SmFUS3pWeVltaGVxUlpuVWpkMmVOTVVOZlBMc3FMRU52cnBCN1ZIR3NPYURJ?=
 =?utf-8?B?S2JpN0JTTlRjVW82RS9MMDNtekNNaFdDVDFqZ0dxd1lCZEI5Sit3dXp5MllP?=
 =?utf-8?B?VVJBdjZWN3lXbzVmeXdnN2FjM2hzRVluY3dZUVNzT3ArNm56eSszZUcvdGpW?=
 =?utf-8?B?cFVnNU5pVlRYL0NXNVlxazJENEtmYThQTFNRVTV3aEhFNHlwektrZEpMMUxo?=
 =?utf-8?B?SVJDU1BYdUpmS001NE5ORHM4cURFTDhjNkNBQ3hjOTRvTDNYbW9MWlpMNTFS?=
 =?utf-8?B?TUJiUmJnamxzWVM5M1dJT01ZTUdmV0xNQUc5TlQrVTYra2phQVZzZHUrS0lQ?=
 =?utf-8?B?R0RpaStLRE9tU0ZLQ2lEcnZZK3M2LzdZT0RGKzY1R0pHc0FHbTJHb1Y2dW0y?=
 =?utf-8?B?dU04dktQWDNSYzEvdEFOSjBBZFVKaXpUbHdWVVoyZTJsc2lsTUN1cnNOVXpN?=
 =?utf-8?B?Z28wV3Y2MEd3M01TOUVlSUdad3RPbEdJUkpzR1hoak1xZ3JqRmVOQTBIb2lQ?=
 =?utf-8?B?WTdFeHAvM0JtWVNxbFhDQWg3MXo5QzdZYnVNTjBQSGZTZUZpOHpCVE5HUW9U?=
 =?utf-8?B?R1NTa3Z1MDRqY3ZEdlZSNjR0UDB5SS95TjVSa3lmbzE0NFRUemxOSStvT3NJ?=
 =?utf-8?B?UXdWUTBCcGNvNFFySTh0am00UnYxSHlKRlFZajBjSnRDRjFjL0s1alkxZmZP?=
 =?utf-8?B?SVh6a0tnWFBRNExTcUoyWmNsRXhZK3E3T3R3QVIwTm91R3hxOWNWNzhNLzJG?=
 =?utf-8?B?SHAwZ1ZwNDBoSVllZTZ1RWQ3M1Z2cFFmaFlyeUlOZ01OeWkzVUoyLzBTdEF3?=
 =?utf-8?B?VWxZRHM1VW5WOHJaMmFncnBnTjVyOHNRcmtza2V0bDdSMHR2cjBZVUV4eVpo?=
 =?utf-8?B?dmJoYXdmNDFkdkJTcGR2MUlOaCtmOCtudVlBUDdTSmx1cHVweTFHS3hMc2x5?=
 =?utf-8?B?RWpxc3hXZUdVcnpkS0hocEdReWowNlBWM3NSK3pydWJSdFF5ZThsUUlYbzl3?=
 =?utf-8?B?SFFYU1A0bjB0eG9tRmZuK2kyWFovcEhwb0VSZlo0K0l2Q2hnYW9MMGVLL0RW?=
 =?utf-8?B?d2NVY1BqQlppclFXSC9tQWxSMjUvL3RXNk5SaUNTWENndHNIeW5qekNiL0Uz?=
 =?utf-8?B?RWxpNXl0akF1b3IyOTB5R3JIUXJQNmZpM2E0ZGtiUG9vTTRTMXJRUlh3ek1r?=
 =?utf-8?B?OE5NNGRodzRiZDY5ZDJFUDhJSEluZ0pWQlNIWHVEcXcySTY2NnlZUmJJMTQx?=
 =?utf-8?B?MEhiWWlhMVdaSmNKTXBkM0VZS0IzM05qR3BkNkZnSzlzSGJlOUxvTHpOWDFI?=
 =?utf-8?B?Y1dwK3l6OGNjVUYrWFBiY0IyOG9Uc2JIenYxOC95SEhCRUg0S3JjZDJhK0Ew?=
 =?utf-8?B?QTZqRGV0TlZRbVpONDUwTlJPaElHUjMzY0toV3poUFFRNFo0ZDJ4S0k5WVVh?=
 =?utf-8?B?end6MGlwMUZnR21xYmpFVzcwcEl3enZZMHYxNXpSSU1CelM2L2E3ckFES09D?=
 =?utf-8?B?S3FYNFdsSEFiUnR2ZjV1TVRYS2x3eWpjblVZQ2ZWTURHdy9kaFJ2VFpzYTZu?=
 =?utf-8?B?eVJBMGZYRkg0NHdFTC9UMFMxZ05YNm5OSjZ5YUpEOGVBZkxMOUVINkVyd3ly?=
 =?utf-8?B?L2RHdVZDaUxqVUlzMlhBMngxbld2YU4vTE1kWkp5TjBmcldUYllpK1BsdHc3?=
 =?utf-8?B?a1gvRFJySCtiNFdycGRmMlZPQ2RFRjJIZmdPMmQrK05DK0V3Tm42dm5sM1Fw?=
 =?utf-8?B?eEh3K3JlZTNPN1FCLy9FZ09qY0lXZll1RGlOWmRGWmpLOTVSa3o4L1QyTUFS?=
 =?utf-8?Q?7Wg8fw07BX9BkpA4=3D?=
X-Exchange-RoutingPolicyChecked:
	H/iG+CAUOsghfTOetwfXw0GA+eUZt7VGgigA/cuxpAPhcpjNWSNPLRIr+WIuSX9UXZbI+Pr6agfoUfCcExAagzUbeKsvvDiPGXriNQfIB+IiDchT42bHmdXeICN5xRVW8g447gqV2Hk2b4KSbe9A7dR7+lCzQt8S8fKdNDqnQ8iWn0otDJyLzxUUwzJng+DCoQ9Fa72h+Iu7pdZjFftM3VPXY2WkP+AGShCt9HzVz2YFRd7Qd4wz4EgS2AywQUTz3lXJZLpJ0qKMi6qEFdDEAESCG/Uw1anJsqprQ+CnODqYBV0whDHZ7vecqhKA1gYLdlDm9pYwFao1G4kqTVIJZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AgB6DGhai3E7nslGis/0kb6eG+lMiNcZS2WHYiUAnLH1qsl2bM1Mep2aYmCA9TcTfnK8D9TxLZxKtigPPCXksF8VfQhXj/Xe9JeR5pzYh0SrMftLkGFRTAwrMKJcO85KJSUsxPkXa3O8X8XQUJ5cIDVOf6kmik7LWA+upEWqyJ7MISjlHTmFwG1dKXIdQjq1gr7b33XirjYEdRQxUfDXF766xfNz8fz5nAtrYuu75HOXf5+IJS2Pd1zsi4qRY5YsH1aRBFmgczGM6R8uP4TMikU9sptmxOyJnIPH/D8Px4Jr2vLF9MuUIHrdVfZE4PGQHlOjbk4NYBFRv3qS52orZSzJ8dSc0VGUkK5DQbFEgUCr8AXxkWk61w6mbuXCKI/y7pZdF5asVCow59O8Pkt4x8FvkWJ1eeateYwMdgInBdVemV8Z4bfj7BJNCyVnNKIjU2Ogp5qnL2fop/teKR2RM6emRlHt56fEcbnMiWxZS5+HGvQRxKjdPRtjhcpOM9xO9+/bpnWCG/hOK/oQ/65Xi3aWRrMAPJdq16QOzZ5O1Dg+YQlib7LGaoJEyP7JcCX+wJyixOXUgtyFRIoyr6TtPWPlIq4zeN8ylrSkTgMHxtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a71a698-7e07-44fe-7b91-08defdfa932c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:02:58.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1MiMKTOB+a0MQ9mDnWKuHUqQlaB5vQc+KJPPXPOi0ocrg6BwG5W31jN60Jv8H83DS3x4pKnT+TTMV/hl0u8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608190109
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX00ZT+taX4kMq
 pqlzza4f8dbzMf3takjV5WKrbMWa5kdYWCk43ul9sYq1u4eT+TlKC3RWbkcBlxPyplQze8zqI+t
 cnpBWPYX6flpY1r71z9AK068YmClQrA50Rz2t/RIVB27efdMBbCt
X-Proofpoint-GUID: 9vJ5oHwjuXT87pnuAf0LHerokxsnoOZD
X-Proofpoint-ORIG-GUID: 9vJ5oHwjuXT87pnuAf0LHerokxsnoOZD
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a85b799 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=PcFDJf7ABtLFBguOCYQA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOSBTYWx0ZWRfX9tU+pHDk1c7W
 wThMvXHrZBwrqB5FpA28WU/NTNFFe85nuQmJByH+WnGbbKyhQ1ligcrXe5BB283Hk1CTg2azh0V
 77A8jmbHl5o1dRv+NZlc8VnTmgbdhibbLfJ3xscQct9qXoRqfW7WehsgtHnghnZI36LzPCI3IDR
 vdr4pKgtDrsZivPHT2q319LEGVg66uEMjcKQo+l3VRm077GQJ3Sbwr88MIGi/TBMmEhF6iavNf9
 xf5GXRbcslGmodJegbqt1Sw92jI1kE7ymK8bHu7MqsrK65S/VgABtCfzbpFr1EQlPdhEM6SARWR
 vSEIEp4lijDAtPY9w0cj/Uy1NOBnjY3NA0jpWDHx2hu8NNIguI1Y75X9W2Jyrg0p8mHn4aHPBAd
 wQp9/EpnABkLsJcpG4fU8P2afdbJARFpH7t7gaT6OMPqUUUQ6fT7shTR/7REPJxYIOzKUo3ce2E
 TG6/33BxtuoE9sgUluCVdvf8eCkJvqINemZYryEk=



On Tue, Aug 18, 2026 10:48:18PM -0700, Chao Gao wrote:
> On Tue, Aug 18, 2026 at 04:42:38PM -0700, Dongli Zhang wrote:
>>The commit b2849bec936b ("KVM: VMX: Update SVI during runtime APICv
>>activation") resolved the loss of EOI issue when apicv is activated after
>>being inhibited at runtime. However, it does not resolve the cause of the
>>runtime apicv inhibition.
> 
> Why lead with commit b2849bec936b? APICv is inhibited and re-activated for
> other reasons regardless of the race below, so that fix is needed anyway. The
> race is at best an orthogonal issue.

I was trying to explain the history behind the change.

> 
>>
>>The inhibition occurs because apic_base and the APIC ID are not updated
>>together.
>>
>>Although commit 052c3b99cbc8 ("KVM: x86: Reinitialize xAPIC ID when
>>userspace forces x2APIC => xAPIC") reinitializes the xAPIC ID to the
>>vCPU ID when userspace forces the APIC to transition directly from x2APIC
>>to xAPIC mode, the updates are not performed in a single transaction.
>>
>>If another thread calls kvm_recalculate_apic_map() during the window
>>between updating apic_base and the APIC ID, kvm_recalculate_phys_map() may
>>set xapic_id_mismatch and temporarily inhibit APICv.
> 
> So the goal is to avoid a _transient_ APICv inhibit in a corner case?

Yes.

> 
> If so, please spell out in the changelog why it's worth fixing.

Regarding "why it's worth fixing," the primary motivation is to avoid
unnecessary APICv inhibition and reactivation, ideally throughout the entire
lifecycle of a VM.

Another motivation came from reading the AMD SDM. As mentioned in commit
052c3b99cbc8 ("KVM: x86: Reinitialize xAPIC ID when
userspace forces x2APIC => xAPIC"), when x2APIC is enabled or disabled, the APIC
ID is expected to change according to the APIC mode. On real hardware, I assume
this operation is performed atomically in a single transaction when the APIC
mode is changed. This change makes the behavior more consistent with the SDM,
with APIC map recalculation being the major user-visible impact.

I would leave it to the maintainers and reviewers to decide whether this change
is needed. From a production perspective, zero APICv inhibition is appreciated.

Thank you very much!

Dongli Zhang

