Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945210;
	b=zxwN45ACLb0PxNuAMC3tRMUg/JcHXBwNfBKVYLnmDKuKqGgH4HVU5eUpbvUO/oVspdWm
	 zWighgICYXA4xMQo2uJ1dOV1pi2vb/iLFrZMtYWxtV/C45iWuAwYeIqTibOPSnoNtt8e5
	 Xp6gBGOgTJXhZMOleVvZkhXJSHkRqDus53evkbY+89MjZGGyE2Hbwr4Yxs24egjwPwT7Y
	 YxK2+jJ9JhR/ymz9z++yOU9EGyEANX4Py285aoAZyq04YLZvGLofpW1TagWdWlL94tYyE
	 U8wL1ggX66WInQYXC66M2nugJRXyuCptxygKvLqeBbK83vzoGOm8wiNrZiNEF/Aha9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945210;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=o4HnvXNAO8rcgAAQADzudVeRhjYc0RMLtxle1YVqL+A=;
	b=I7kgg2sdbFtCRI1jNbYMlzkKCHHIRuywBNSzSt3yh12HQQsIs5ZsgqHhkA8p+EGeXFOI
	 /yQQs1w4rzC0i8t7ANQgs7jjqTq2GPLcgsXl7AyBRbT5N9X5C5c+U1f5xf0svRs7QLNOS
	 v0Y3zq1aYsxUrAM6psu1rGh+zlCbMraeErqj8F6yvn28gXjLexkBv04IJrHA1r5PAqWvf
	 CMHh26yVRRZAavsXTYvVax3KP8K2TT0IE0rOBndb1Hj+qnvAxpJW00nQ+EcEWlPX8J2hH
	 Tf7fQBQ2FZGxhNMaDyeL8pclhshssbH3YFzu4HWS35vN/guTt3KFMXkUMbX89LUQNvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=cYckwFN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.78
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021078.outbound.protection.outlook.com [52.101.70.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D1606A331;
	Tue, 17 Nov 2026 19:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9D1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=cYckwFN6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpInQs2rWJiUhflCc4CumC6fQH+BoV+9JT3fCb+h9xocyMhLO2ISfRCFQICVViZUFj9SH3Hp+koHxuJCm0iv9uTTqr44vLKbh5gt5ILesB5O2pCM+583A6HuyhxgKvn5/Ukjkf2DGtKfjg9XsqSQHnLUZZTMKgUEM1NXJNQFbupTiKRzWARcxRsDJnol5EMg2i+gzUurFB+8EguRsYh8/vqgAdQlYxJcFcJwbsJAHcFIuC0zFkVKopxkzi96IzTmiBTc6rQBFmtQ2GwJ6ARBZiXqf/hncJTZBHveO64gbuVCpCTlI4QvGJVOsXhIxaSmWqBxbrZiwO3VDGn8grtQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4HnvXNAO8rcgAAQADzudVeRhjYc0RMLtxle1YVqL+A=;
 b=IKX6zpDgpXPbXUjqIXYPG+jgXFBtpduJK/2L207BXHFEwAJwVBRVs9qNBLqTKHRW9j0W2KxTJPomtJvbvBgqsDqjMz+EsCB1gjmeTyXbqTXpPnxdUHdsZu0f4FCtqvygtpU7ve3ubflCS5sCJgeCQrMSMLtEFrCZpV4fETz9RCw54YcjTv5wbS5Ycseh1aYmKhg27L1/biEHMUIZODP963ba4IzCJm77w/wLXFcnu43V2BSx8KUCHUccqxgpptPqLfkUJmRNFhivzHzYBxa5cMl9Fzq3qTDB7hq3jGlb+iwQYmaI0S+0eIml/MCJn/eJW8gXHRcoWq9VVJF2adqjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4HnvXNAO8rcgAAQADzudVeRhjYc0RMLtxle1YVqL+A=;
 b=cYckwFN6KDbmZCmlMwweEWDbzzQp1rd9k8AAYNt8A3m+yu/69rmU+sPnJfcigJAPunukLHqtFRnBp/BTI7Su1YkanUOjI3U2V+1dC2dc++4s1gRFwhpKNAkOWfKzbdlHpoCg1Pc9sye26of2ibsgT26oaRpTYS6LSsxBXg3oieru7KcWLTzreMoEL7q/jGv3eAgv50cbqRLCAO8KMgWmB4WJ34i4qiZwSXMAFtiriefe8nvJfUx68dNjtWhVWvnXBAGN8W72wYmCJGFOxzLrwS8PbBO1ZgRVZeksmCn5j4Exff80VpU78doyOF8j1IjkWiXnyNfQ6r3Cxv/27+CmrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by ZR6PR08MB497186.eurprd08.prod.outlook.com (2603:10a6:910:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:53:27 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:53:27 +0000
Message-ID: <62df7b70-4efc-4a3f-a3d4-e4ad19875c1c@virtuozzo.com>
Date: Tue, 17 Nov 2026 20:53:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Fix lost EOI when unmasking a pending level
 IOAPIC pin
To: "Denis V. Lunev" <den@openvz.org>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261029-kvm-ioapic-eoi-v1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20261029-kvm-ioapic-eoi-v1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000090C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::92b) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|ZR6PR08MB497186:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ed55fd-ef4c-43c1-3b4f-08df44e472ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IetSW14zU0017EMDSUhCpcHn5FNCoG7BDEN0aKTCRIuseqT5uwFtIBZCuTq6//bQK8tSu2VK4BNlSuWWGj+Auc+ZujjiHvzVs91Q/23FGcEQFe995+mSKqqKfF74kUR8JNlAboIDzbUeDdgMXqfP1zZvuqlI+k2AzWIYnsVIpK5VEYeHfsf/knwhleV86M2dqDykJLnNIKhggGl/fAoOlt4I+a9F9BdYpLO1V3sk07tzyX5NBor10/STtwjnMCKEwIo8nVEFNDlvqFCXcJCiTL16LuSKBcp+UxEsOfaGo9ZWzP8K33rXtjGRlMBcptFNfoH9IUDAnyoFe7aKAAQBiEtVI0offXEZ0wiOAYrQPbyAsOb+Oy7QFyHF00NBCSIawuDJpqyhLQqz1j6zme/jQ12eKTP0yVMNI8x5EnH2bfjXbYBB3xXVTm31TgOfeBeajidG1UUZx+gLeaJqGRaQsBK16vkOmY4z6QTcz7pDLCqVJseEb9iDY3uOfDxdGMz2F2i0V1qK16HLSgWhX0bvnaGt4zUmW4guCZeEImlsMN3aASKbq9o2UR8B2ky3yaoXayob7HI9IQRg+knN4kAuzSs6yfVLELRWcFMO5Nsd5kL4SH97DfQ4nydv3z4zgx+uEJuil3C3s3ntENl1z1wrDjSbPYO9R6SX7qTXjrJYgxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2xhSVZaQ25WZmhQQVgrZVJvYWxmYVcyUFVKZ3NSK1FManJQc01BMVY2Wmhv?=
 =?utf-8?B?THNsQWJac0dyeEh6T0VmbXlRZ2R6czZ3S2kwTFFwa0xpeCtHbVY1Z3EzbnI2?=
 =?utf-8?B?cmdpbXNOcC9CdS94ZFJUTTR1MmNRNlFmcGowbE04VkZmcjVpa2dXNzhQbEpT?=
 =?utf-8?B?di9ySWZZZDRtQnpGb3NSRkpCZ2N3TTFQMGMzdWtJWkNzR0hqUTdPcnZiWmNP?=
 =?utf-8?B?czI5VklhYXVzTFIzbnpqRzlGckpjLzA4NjBOeUc2NitKSjVwd3hlOHhiZHVi?=
 =?utf-8?B?V2kzVFRBMFpuTkhFNHhpOFQvQ25rZDVHYVpnSTh3NXM3Z2F5R1hKakMrVzBJ?=
 =?utf-8?B?N0VPWHo0ejVnd0dTRElxR1JFd3FsK0VNb0hGUXRsaUtwaGxHR0l0QVRLSEEx?=
 =?utf-8?B?a1NFL1JHUUlRS01HNjY4c24wZ0Q3OGRCMmJVUndoL1JVeitaSm9uOE1OZXhq?=
 =?utf-8?B?Wmg0aSsrRTU0Yk56OStXUzRDQy9EYTVmRC9VV1V4MHd5Tk5sdDY5UFYrU2RP?=
 =?utf-8?B?UStVeVhYUkhJVGV3UUFQS2JYbEcxL3dXTThmT2w2Tzl1bmFBdy91aSs5Smwv?=
 =?utf-8?B?eERNcVBHcGRKVlVNRlE3ZFBFOU92Y09kK0ZDTVYzOSt2ZlRBT1VtcFUyMHh0?=
 =?utf-8?B?bHlvTEt3c0doVmsrVHQ0RkV6K0Q1YmtHZ1dKMUdPaHQ4Z0xYRzZFTnY1Q0sz?=
 =?utf-8?B?R1pZcElqdkR2bS9rRFdLNHpSSHpCejEzTGRGREZLbVNWZmRBTGZacEgyY2Rr?=
 =?utf-8?B?eGN3Umd0QnAvTzRPQzk3Z2VXaGR5K25rZ2lqL2o2UVR4SllYZ3ByZUVvUVBJ?=
 =?utf-8?B?Q0FXUnMxVUMwMUQ4VWlRcUJTZHhDcWtGdWxxdThvZ2QrcUQxdmIwMndWNHlI?=
 =?utf-8?B?KzdZUVd4VFRTSWdkd3RjZ3hLWHZLY0ZDUW5vcWlZc1FHVGJ1VjFYWC8zd3Vx?=
 =?utf-8?B?M1Zqb1JzK2h5WnUxeksrbDZNUCtBaS9ibDR1bVdyTTlSMFBXN0VHVm5Sbk1z?=
 =?utf-8?B?T2hmKzcxcW1wQlk3ZFpLbTQwZ090WDUyNTJMd1NodWJpWkUzTENQYVlUOXAv?=
 =?utf-8?B?c3lXb0VVQ1UxRi92NXhqdytnaHR1eDcyWUJEN3Z0STN5eXBZbm9wbi9nY3Vz?=
 =?utf-8?B?Zlh1N1JXVUtvNmVoNkwrb3dCZGR2WkRZcTZuM1dNR1lQUzFWd0U3alBseGtJ?=
 =?utf-8?B?WHR1T1lzN2Q1bzBxQ3VsSW1yN25QSWJlYytWY2ozanJ2ZHB4bHpGS1NEVEQ4?=
 =?utf-8?B?dHZMV2g0L0p6NW9XbFJjOUEzVnBPRkxpVnJRR2V2Q3lxMlFqelZJZTlxeTRv?=
 =?utf-8?B?WFNOa3NyNU5mK1J6eUVJNy85cENrNjNiRWVybEw2MWZsdWJXcVBtTE9jelBY?=
 =?utf-8?B?ZGRLWnpheTZqZ3lRckJWdEQzU2FPa3JLTUVuTGhGTVg4SC83RGtqNDNTc1Bv?=
 =?utf-8?B?bXhMa3M2aWppMDlTWWI3eE9nQUE3R1BaQ2RrbzNFQ2ZDc2NHQjNFZUQzK3VK?=
 =?utf-8?B?Q3Z1czFTRFIvdXRGdGR0UkpKYTR4aWlsaWk2aDdncERqNUxpaVJUY2lTbjZR?=
 =?utf-8?B?QTUvRXhTU3BvSG1ZcGFQT3dtL01NYmZJellGbGZ5YnFGdUIzcjFZOUVLNTFa?=
 =?utf-8?B?NGNiNm9nRXo2aElva3lnTnBoUDVjTFNPTkpUSEVVWCtuSU9DZDdDVUxrNWg2?=
 =?utf-8?B?TWdHM1ZBOVlacnVUMU5MdWx1cDFLOXZBWG1GSS9BSGY1SVNEajBMMDlETDRP?=
 =?utf-8?B?c05XMzdnb1FIbktxM1BDUFE3V3ZpUlJZeDdvZStCYllLUVZ6bnBpNHY5M3Fs?=
 =?utf-8?B?U2dIR1VwMk5XajczU2lRZDNTL2MwM1ZuUEdENjN4ZGtFRHlmd3BwSFNKaGww?=
 =?utf-8?B?ZGl4Zm0xTVI3ei9xUHBTRHZwMzQzelp5am9xNDVsWUl0M1c1Qnl5NXpIa2lZ?=
 =?utf-8?B?QUt6aE13U3Uva0p0c293ZG5oU21BTkh5QTNVUzNscXF4eU8wUGtGOGg2aThG?=
 =?utf-8?B?cWQwSHZIRE9vQ3c4NXpoRkl3K1prT09FQTFNa240QkRUMVYwWThTZGFNT0xE?=
 =?utf-8?B?SFozNEg1d0NQY3lveGdjaEQyR2YxSE1nZEk0bkZ6UmZweVNZbWxOQTg2ZjJz?=
 =?utf-8?B?eEtEaUxhbzhlUmliY1ZUYWp1bGpwOXdWNUVCcXZEbzJSb3FNdEc1Z1ZUTVJW?=
 =?utf-8?B?bm9zNE5WbUEvS2VxM0VXTWF3aTU5OUNsdmV4RkVYZ3kyby9FTjJWVDA5a3FS?=
 =?utf-8?B?V1Awa0lkdEw4ZnpqemhRS1NoVjdxTnJqd0M0Vk5UbXdGcU9uVHd0SEp1TUk0?=
 =?utf-8?B?T0x3WWtJeFNlQy9NdjZTNkwvL29uc0V3aWNEOTNMQnk0c3RjNFBadGh3cUxl?=
 =?utf-8?Q?PC4PxwGl3vX0H6Zt4ktnH29qvGNQCBwgK7/0/?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ed55fd-ef4c-43c1-3b4f-08df44e472ad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:53:27.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wQZtwr1QQ/3lSPGIut4XWBSkmtKsAId7r8N/sjdpjgTekbp8oKDKT22quzJuIGsnd4sjsLin0IgzmvcCG8P1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB497186

On 10/29/26 21:02, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> When the guest unmasks a level-triggered redirection entry whose line is
> already asserted, ioapic_write_indirect() injects the pending interrupt
> first and only then asks the destination vCPUs to rescan their
> ioapic_handled_vectors and EOI exit bitmaps. If the same write also set
> the vector or the trigger mode, a destination vCPU can take the interrupt
> and EOI it before the rescan. A posted interrupt reaches a running vCPU
> without a VM exit, and the EOI is then either virtualized without an exit
> or dropped by kvm_ioapic_send_eoi() because the vector is not in
> ioapic_handled_vectors yet. Remote IRR stays set and the pin delivers no
> more interrupts until the guest reprograms it.
>
> Linux programs the entry masked and unmasks it with a separate write, so
> the vector is scanned before anything can be injected. Windows writes
> the vector, the trigger mode and the mask bit in one go. A virtio balloon
> on INTx whose line is already up when the driver connects its interrupt
> then stops receiving interrupts for the rest of the boot, and the guest
> ignores every later balloon target.
>
> Make the scan request before servicing the pending IRR. The request
> waits for the destination vCPUs to leave guest mode, and each of them
> rescans the routes and reloads its EOI exit bitmap before it can enter
> the guest and take the interrupt.
>
> Fixes: c7c9c56ca26f ("x86, apicv: add virtual interrupt delivery support")
> Fixes: 3bb345f387dd ("KVM: x86: store IOAPIC-handled vectors in each VCPU")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
> Reproducer: "[kvm-unit-tests PATCH] x86: add ioapic_eoi_race test for
> unmasking a pending level pin", posted separately. On a nested Intel
> host with APICv and a 7.2.13 kernel it loses about 95% of the EOIs in
> the single-write case. With this patch it loses none, the masked-write
> case never loses any, kernel_irqchip=split is unaffected, and
> x86/ioapic.flat passes.
>
> The symptom in the field is a Windows guest whose virtio balloon is on
> INTx: the balloon raises its line before the driver connects the
> interrupt, Windows programs the pin and unmasks it in one write, and the
> balloon gets no further interrupt until the next boot.
>
>  arch/x86/kvm/ioapic.c | 66 +++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 0d59b9c758c2..8cca333cdc9d 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -384,39 +384,6 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>  		mask_after = e->fields.mask;
>  		if (mask_before != mask_after)
>  			kvm_fire_mask_notifiers(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index, mask_after);
> -		if (e->fields.trig_mode == IOAPIC_LEVEL_TRIG &&
> -		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_irr) {
> -			/*
> -			 * Pending status in irr may be outdated: the IRQ line may have
> -			 * already been deasserted by a device while the IRQ was masked.
> -			 * This occurs, for instance, if the interrupt is handled in a
> -			 * Linux guest as a oneshot interrupt (IRQF_ONESHOT). In this
> -			 * case the guest acknowledges the interrupt to the device in
> -			 * its threaded irq handler, i.e. after the EOI but before
> -			 * unmasking, so at the time of unmasking the IRQ line is
> -			 * already down but our pending irr bit is still set. In such
> -			 * cases, injecting this pending interrupt to the guest is
> -			 * buggy: the guest will receive an extra unwanted interrupt.
> -			 *
> -			 * So we need to check here if the IRQ is actually still pending.
> -			 * As we are generally not able to probe the IRQ line status
> -			 * directly, we do it through irqfd resampler. Namely, we clear
> -			 * the pending status and notify the resampler that this interrupt
> -			 * is done, without actually injecting it into the guest. If the
> -			 * IRQ line is actually already deasserted, we are done. If it is
> -			 * still asserted, a new interrupt will be shortly triggered
> -			 * through irqfd and injected into the guest.
> -			 *
> -			 * If, however, it's not possible to resample (no irqfd resampler
> -			 * registered for this irq), then unconditionally inject this
> -			 * pending interrupt into the guest, so the guest will not miss
> -			 * an interrupt, although may get an extra unwanted interrupt.
> -			 */
> -			if (kvm_notify_irqfd_resampler(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index))
> -				ioapic->irr &= ~(1 << index);
> -			else
> -				ioapic_service(ioapic, index, false);
> -		}
>  		if (e->fields.delivery_mode == APIC_DM_FIXED) {
>  			struct kvm_lapic_irq irq;
>  
> @@ -451,6 +418,39 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>  		} else {
>  			kvm_make_scan_ioapic_request(ioapic->kvm);
>  		}
> +		if (e->fields.trig_mode == IOAPIC_LEVEL_TRIG &&
> +		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_irr) {
> +			/*
> +			 * Pending status in irr may be outdated: the IRQ line may have
> +			 * already been deasserted by a device while the IRQ was masked.
> +			 * This occurs, for instance, if the interrupt is handled in a
> +			 * Linux guest as a oneshot interrupt (IRQF_ONESHOT). In this
> +			 * case the guest acknowledges the interrupt to the device in
> +			 * its threaded irq handler, i.e. after the EOI but before
> +			 * unmasking, so at the time of unmasking the IRQ line is
> +			 * already down but our pending irr bit is still set. In such
> +			 * cases, injecting this pending interrupt to the guest is
> +			 * buggy: the guest will receive an extra unwanted interrupt.
> +			 *
> +			 * So we need to check here if the IRQ is actually still pending.
> +			 * As we are generally not able to probe the IRQ line status
> +			 * directly, we do it through irqfd resampler. Namely, we clear
> +			 * the pending status and notify the resampler that this interrupt
> +			 * is done, without actually injecting it into the guest. If the
> +			 * IRQ line is actually already deasserted, we are done. If it is
> +			 * still asserted, a new interrupt will be shortly triggered
> +			 * through irqfd and injected into the guest.
> +			 *
> +			 * If, however, it's not possible to resample (no irqfd resampler
> +			 * registered for this irq), then unconditionally inject this
> +			 * pending interrupt into the guest, so the guest will not miss
> +			 * an interrupt, although may get an extra unwanted interrupt.
> +			 */
> +			if (kvm_notify_irqfd_resampler(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index))
> +				ioapic->irr &= ~(1 << index);
> +			else
> +				ioapic_service(ioapic, index, false);
> +		}
>  		break;
>  	}
>  }
>
> base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
ping
