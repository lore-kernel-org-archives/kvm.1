Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D53803C3;
	Tue, 12 May 2026 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629475; cv=fail; b=NmMpaZosu0qwhI8bAJDKcZb/N3nLpgP+KDBZSCJnA7+suFC9yuMbapROdRXt6Hf0I2M8NJWp3FM1byKPpsS4CGPyc/SltuJSlT+/AuciBEyP2fYXviDSCi2wCp+jYLKsxwHqPUIwG21dyKPAFiZyJsX7VFPCElKuaKWt+foSfJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629475; c=relaxed/simple;
	bh=sA6YM+lVH+oETN+1gxl562oUisBaJzbl9j7w5oS7M8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4m/RQ4u/qsELeRyXfZqvdBxFzQ2gLtb0YhnlI4m+13rgY+saHtMR694YZi5Uc9E+fKuf1NRtUdsjOIedgz+4etcMjUc9RHZZAzGZ0Kmk03RhTziG0GCsIFa+m6CAIc4+LZYzrhCVNHQaRkrCPBG91drjfA0cjxi5JTFJQyPJdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EGJzyxJI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyiWYfEO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGJzyxJI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyiWYfEO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CMv9Qn309361;
	Tue, 12 May 2026 23:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y9DnDwABQX6dHC1Hym5OKy/nSVWGNzidA78XGuK07gw=; b=
	EGJzyxJI4MXujm5rrWwSilwqXZbP2ylikNAroA12rvHczXus7DQxZ2Cv7JZ7WdS0
	N739GGfqNWuL/nMhgMOC3vHuYjyZU+4f/X04sJl4v/9O92SeeDr++jha6I0qPf7R
	xTSTyuBUnTceHN+LEHWoc0aKV5VHRJNucNiXAEwhIlvnQIbWPoUPlwftdEQxPWt7
	iFQWfySYA3LFa5zP+yaueBO6qM3+WhrcdrubI+jMvABxJcviJybe5iiWuya0EJb1
	qZ0aEZAfsS+CSs1ebOnYMaUkiI6GITAy5zqK+sMzuxxaIbbYxPt0sEugkkXVF140
	cBNOPpOQxFepbXXwsMC48w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c96r615-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:43:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CNYssX034364;
	Tue, 12 May 2026 23:43:55 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e46rsqjns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 23:43:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8M5Z+aweGonN9vFrwriuTj9/SxQzZoQVevyBhaxGwRTsD295ajeUzTPbRizPQpTuD0JccVhEsgXHNnt4IDqP/bsPwzfXKpodJvCiFI1bLewutboU4q/h+lPBB+xGi4zVpZ/Z94MrPFqK+VMrzwekHU8VgNRRjXaV3mJyPoZU+yIzbFoMNeCVqALaFsGLvHlBJYKY7FHLIPHI/lP8esPQf3uZo47pNOEepPKxQvtLehxcuBVs9ew3bFHh1XlAG16sLGnk/VboqxhxT7KSmYg54u6atKofcUaxxVaPgkTOeqzNnWfdljPoPsK8WEIrsRhBQa54LA/RUjb+oUz1eIRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9DnDwABQX6dHC1Hym5OKy/nSVWGNzidA78XGuK07gw=;
 b=MwLdctKJHeTXz96KabXUeYrRt/TbIctpqk0HQbRCDTTkjlHveTsVKubeAcWxkwhwH2QP9Edk96AE0nKsZCjJe0AFeZ4bBCXQf3AvzL3OgDxHqnNXFQSVFxw64ZMytf2v80vdMGk/1OVSyRRj8v8OTs39yXW5UuJV5GgYR+FT6wCt4Zb3Hmk2R//aSGrmPTA28/cHb2BxhUxk6o1r92+9nUfG8kcVYDhywOBo2thANtzrGx/ixGrJ9ww8vXPWFrSGLXVEQPJFvVU9az9FnVWXK86dUdwWyRtdNEkSnl33x6Z4cKkp/wylxzulRegfGhrig/SaKOW2ism+hMzbh0hi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9DnDwABQX6dHC1Hym5OKy/nSVWGNzidA78XGuK07gw=;
 b=DyiWYfEOBTYJUlub1xbeysrFW/KVlVQCohHxfwGfrZhu6RP8u0GNKUplgzyzGtPoA97um2OvfNL6KdxeQWuH73pLIQ0l0Z5d/EtoF32Lu1vaKw5L6r4sru43TqaUrzfMD08VK98OaR7/ha8qS/29v5NRXfQ7If7j4kko3t3uems=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SJ5PPF77807A52D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:43:51 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:43:51 +0000
Message-ID: <f279a4d2-8f7d-473b-adb6-66183a1e12b6@oracle.com>
Date: Tue, 12 May 2026 16:43:47 -0700
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
 <53a294f2-1812-4ccf-9bc8-c61a93588564@oracle.com>
 <4e23483e646d8581416158268cef74f9bfd6eb54.camel@infradead.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <4e23483e646d8581416158268cef74f9bfd6eb54.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:5:100::23) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SJ5PPF77807A52D:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe3428d-c7c5-48e8-ca99-08deb0805203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FJ21zP6ATN1zHrnJAlIfyXizRj/FkO5ZWZVpqxNA6kvyKNdosXCWpM6p64q5wM0ZlSAu9xyRs8ZhY6okNfGN12l/KmSWFLzJdcvzfzAEF9jA0WjZYhYww+uqA7gcgKuyAzOWgYoz3uEIUQALUknIhxhfKkHaycMIm3k22XfkkyDVsIMUokMWIelta+eITyV9EsIP1neidSMMiurVDNDxz/ykkkhFluDaLoOHoNRjZxAowmcKcwaY4mmTXFSUpFZqNVM7O5fMylc9cP2OUCpPpCA0SL3fNOQoNKgM/vSMHXyTJYZEvPkJVQo40MGUYhzpPtlw2fFgFvE7GVINZUr4eCwOKpnN6+eX2DTLBZl49h+9EsYEmNiqNXeqLd9FfwXdTKAh2Nnjh0uTA11ngThv8m2JKtwglreGg0KSFApnKVGsZmaf5up7haXr0L0HsFdhlxLel86HqHdyN5xDpzGsFi6jXndp9oqomP5GL4cEbN/5WG1He7p82BnJpWNjDDG2/Vw8cAhnxSIKGNme7PFnwmt9vUzA8F7ffGpEtJ/mTpm4SsXptHoLFlanjyrJMT40LzdWQAUsFxu79tZsYmEXlKTq9PEgkzsI42XZ1Zo88ZpPzwBA8HlpeUpyXQSPi6cUYTl27uLJD5EYYVfEpiu3eYaBnvubYECZ/NcJmbv8XxxLcn9QmMk4MBo/Y/k+ppCC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEhVbzROYzJVRkwvZEQvaXFkNVhUayttTkhoeWFIVVZCVTdLenhmMVlWREs0?=
 =?utf-8?B?WDhqU1lWbzE5dTRsT0pIVVRzRDE4c1VaZjdLMVhvMWFDSlAvWkpyRDBlVmNU?=
 =?utf-8?B?bjZxNVFTMkxvRm55K2ZQTTlkNitwVU5UK0J6TDdhejA0N0NwZlg5bEZ2VTBX?=
 =?utf-8?B?c2E0K2paM2lxeVF0TlNtZnZxZ0x0T0NBb09qVFZMdVFwQTVDRnNUKy9SS283?=
 =?utf-8?B?emZPdlYrak43OVFjWktXM1l0cHQzZXhGTHFXTHlieHNTN2pKenV6MFJyWVNT?=
 =?utf-8?B?SkhhSXNGSW9RNXAwMnBWVTc4S1FKOUlldzJCYW5Rb0RLSnVSSURjcFRXUDFU?=
 =?utf-8?B?aElNNDMxSlNVU1pKTU1DWkdqc1o4QXVEbGhFeS9Pa1g0VkpSY1F2MmM5aVp3?=
 =?utf-8?B?ODRzNDVYV3cyRlF4dWFyZGlyeVlnSlNYQm5tWlhLREh3WkNzZEFjSm9XNTE2?=
 =?utf-8?B?UkN0bm5WSW5qbXN0aHdPekc4QWtNVXdoU2xEVFVaSlh6TC9wRGhrK3JOQnE5?=
 =?utf-8?B?YklWd1plVm1SazMwRm9xVXIzRCt5clBibWprMHh0Z0NTd2JnNUU2QzNaVWZx?=
 =?utf-8?B?OTZRellwWFRhdFk0YW4yMkdnaEdqUm1mc1EzOFNRNW9zVDZ1NldjN0lKODFk?=
 =?utf-8?B?UG1lVUpLdkxtaElCUEZLSmdyVHM5elc0WVZwU1ZrYm9yUHVqVmpxaFh4cTd0?=
 =?utf-8?B?azJCRldUY1dOMWdkN084WU50ODIvWXZKM1IxTVdSdnNVWlRLRW1WdVlHakpK?=
 =?utf-8?B?MFk3aE5BaDFCcUtIT3RIY21oUklPOS8zekZTK2g3enpMUnRma1lvcm5ja011?=
 =?utf-8?B?a2ZjMnkvR3pyVEk1dnVsOWNScHF2TXBLRUgwWFpNbTRvZkUwVlFuMUZxaGJ2?=
 =?utf-8?B?KzkvYldCMFZzTFVyaW1namVFaEt4bmwycWxsYzlHaFM1MnpVY0J0Z0wyYjJx?=
 =?utf-8?B?cmx0UjZvcmpiWkFnNVZTdkhXNXVZTGUvbTVjVDlhUkV0cWdndjBybVhhL0pn?=
 =?utf-8?B?M3JmZHArd2lrSmNVanpLUEtQaE51WWhHSkl0dkVYYW9vM0R5d3N0NDRqczBJ?=
 =?utf-8?B?eWR2VDRCWHp3T0U4eDkreFBhRndSaHhnL25XVFZ4Qll6SVdNTW1EbjdseTZo?=
 =?utf-8?B?SER5N3M5eHBkOUlaMVZSOWh1STYyWDRkVFdYM05qK0xIL1pDNXE0aHIrbUk0?=
 =?utf-8?B?dmZoZ2Y1UGNxbHFhSTNoRDZrRTJNaHlDR0krZ3IwdVlXc0l2TlQyWWE5WjhO?=
 =?utf-8?B?bFhTVU1EQnB3MFloemdDWERGVHBPWEF2NkZhVnB0ZUtPSG5GRzRBMGtpM0JE?=
 =?utf-8?B?WU9iaFpqNGh6bTlWZTdKRTdESTVITEtWSGQrLzNQN3lLdi9GaDJ3V0hNRllT?=
 =?utf-8?B?MnZlS09ZYlROZFJINDl1UjhFVk9PcnhoYk1kekxqSm40Z2hhTGdWcW5iUG01?=
 =?utf-8?B?b2o2dlVxMWFxbGdBWUs4eGx0cnFYcGw2aUdhOERRTVhrTlI2MExDdGt3THVM?=
 =?utf-8?B?cTdqV1Q5T3NsdEpsWGI0MnBhMUlnZktvcDA4eldlaEVCQUtLOG1aem5FYkMv?=
 =?utf-8?B?MEdSV0N1NmRoQnNqaXI4MTNXd213TVJZNmFEWXhSQXcyTHRMRG9MWjFCQlM0?=
 =?utf-8?B?dXp0MEU3Nm9ZRkZQVSt5MEFBMkpwcStSYmRycEV3dkptcW9NSGErUWsweGRU?=
 =?utf-8?B?SEdVaG5ld3RHUmsrOHJBM0RHLzBIeCsxdFNJcUR3NktFb0F5SUcvZmpoMlho?=
 =?utf-8?B?eE1lSlJiRisxYUY0emtLZGZIVFp2SCtwUHNTd25NR1IxTnFGQUtYeFB5V2JG?=
 =?utf-8?B?YU5uZGRZNTVqamswNjY4S1ZObXUwRTViRUJwSUdxdHRDRlJJcWJERm9lWEJy?=
 =?utf-8?B?UElldDJQSktLVEJhWXpmczFOZ0tNNUs3SFhJL3lPYk5TdTNJMjhvbXRXSVFo?=
 =?utf-8?B?K2JlWFQ2SkdEVHJWVWJiQW0rMDlHV1VnSUdSUEFBcTRBOWNQZGs1QjN6V0dS?=
 =?utf-8?B?US9WeE53TzdrYi9JNTNQUlRyWnJBNk4va3FhSCtRYzgyOVNRVlRPMDlUeXFt?=
 =?utf-8?B?M2VIUEl6TFVkNGhBL0FQcXh2OWNTZ2JoaEp2Z0RLa2F6LzhlMFV5c1oyb1N6?=
 =?utf-8?B?clR0VHB2Nkd0QndqTnVGMEZUVUhUdk10UGNnRnhXZklOYThjZ1dWU1dzeThx?=
 =?utf-8?B?S2FnTGZPMTFrWVc2ZFJoK0phZUc1UXlvU25XMjFBLzh0UHRMZjM2TUhYOUZC?=
 =?utf-8?B?anpJZVU5YUU2QmJ0aEhncm13a3dCODhuUC9UZG1iVGdvYWhSMHo5bXlvZi9E?=
 =?utf-8?B?ZFpVdmhpL0hrbEo0Q25DNDlMYnB0Snk3Y0xMTzVMa2lXbnRqZ0RRUT09?=
X-Exchange-RoutingPolicyChecked:
	LtR46pr2chNGmm4HO+5WjtT9MUJ1sc0PJXLUtbmAPVkem1rrSzPTS9PGO9X4kLMzIFEjTmfQbbvI5NygGIdF0aI1oyhJfPm7HSJrpLOW2QSXNl0KnSrJeTV8m6j5FMsTGaBkUJyYFZr4G9gfC6W4siNrLyw6koBkGdTs+eP2sDil0NmAvKLrwyN+o1/t2F4Gy9viknrKWPhO5wPubEDxAgehCiuRoJ8uBIzPvIQKKI+4kkjWNjewZEHQsK1haJ6DzBWLX5HrFYrsPg8ZhyzJh94Z1tKiGXPqTYpuzt2h1jbaJAEAOEFt/cYJaqWDsJCb/ZIIxcNMYmCHvaZ+xfBw7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WX64LnPjH+JG5Wnxj8dkEOQTxuKHr1OsEfUP7xDNjf2q2wGxdldy8tHFz7lgvCt91wZu7JnCH+hPLR88M1/J8Y9v4Mq8ljFMcN+X9ImK10856Abg+Itj7r3/uy2Bd+hDPn85agJyRQB77ROWfwMzdbFHotpzehS28eEiDLVBYqRTmvMNeVQ1zGeeH93pQj/fh2OptzaVVTnRzWpdsCeuQNXDZMjofn4zTK4gFSNKiVbsebXHWPXiFzJCoirZLFe2q9K1KHBJRJRspmm0M31RSPR+Z/W769e8izlM6eBl5HagCt65o831iW3qA2uOVgc2e3HZUuZfL8GZ7+qq+JZik0S28SUuUakRQaD7hgA2NYDuXrySjgxUbU2/rM4kREWwwM5a1actE8XWyIftG+JIn16ZTgdlGUqvY58UmQMHMuN5JHSFkQGlIk6PGS+5jYSDgOPxPEm2Lu3m3WJ5oeIiXiMhBnXkgCuVTZR8uT3r+C1aPwwOiEXGmi/nfjFlePiNxh1YrDgjvxstzbyZMuCe7yqOQyX7TMq4CASZzL8v5YTbD53PxsD0Uu1DsFYC3zX622fkVhQciQd7rmZR1DZ6I7OMaB1pfWemBaapGyGAzJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3428d-c7c5-48e8-ca99-08deb0805203
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:43:51.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RrKzmnG9mn0mgLDcCmzB/F8RddBE3tFQAoxloGOR8+pyKi/5Lmq7PgRqcoue8wI4L32nWqRoIWx/ndUY6Ge3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77807A52D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120242
X-Authority-Analysis: v=2.4 cv=bbRbluPB c=1 sm=1 tr=0 ts=6a03bb3b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=Nw950aP3uyzhhKGONJwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H0XgHXGVzLXr9zQmXfK75MNBPsWQC4jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDI0MyBTYWx0ZWRfXxc26QKd9EEX/
 wguASMej1AzY+QRRkG9/bLdeKqe4ubc4gveEgDiLjEK92eYFxpHWd+jy9SVZ2eIwG7BNNZSdBrP
 olNg6s/e8ch7CjbRUVZSJOSnO8tyvajY7RgT6SCAHKUK5C0EoPGr5F9jd5izPM/wwmrKbf5vi2M
 5ec06KS70P7qxp52PtVswAGko8aOmhm3c5AnSOuX0nR2hbablHvU2A38QO44aaoe3uWAAV0zryz
 D9rUkSaPzAEIgtvJbeZpBf6XRhBVo1ld+UjXcKOo+ylJ/IBIlBOwO5bG1OeASvUYvoUQfsy0m9f
 ylw3dGY8g9m3bS45X2xzJln6dX9YC7EUU5FuAbdJmMub6HpVWwpzuIK/cM2GElccwAm4rbVUeoe
 yxWcXvTlkt+RkHmSD3N4ZPiDGGGpyO0bGob/atBkjf60kUK6mC+IDh5bmTBasStOn9htQ7miArq
 wNm8BOkkQx+kbE91+wg==
X-Proofpoint-ORIG-GUID: H0XgHXGVzLXr9zQmXfK75MNBPsWQC4jl



On 5/11/26 10:46 PM, David Woodhouse wrote:
> On Mon, 2026-05-11 at 14:27 -0700, Dongli Zhang wrote:
>>
>> Thank you very much for reminder! Base on my understanding of source code, the
>> delta between vcpu->arch.st.last_steal and current->sched_info.run_delay (new
>> thread) won't account downtime if we handle it properly in
>> kvm_arch_vcpu_run_pid_change(). I may also add that validation to the selftest.
>>
> 
> Do we ever *initialize* vcpu->arch.st.last_steal to
> current->sched_info.run_delay when a vCPU is created? It looks like if
> we create a vCPU in a long-running thread, it might immediately be
> attributed a bunch of steal time due to run_delay from before it was
> even started?
> 
> Xen keeps track almost identically, in vcpu->arch.xen.last_steal
> (because it's delta-based, and we can't just share arch.st.last_steal).
> The Xen does *does* initialise its last_steal... but not on vCPU
> creation, only when the runstate is restored :)
> 
> On kvm_arch_vcpu_run_pid_change() you probably want to account the
> run_delay on the outgoing pid and *then* set last_steal to the
> run_delay of the new pid, yes?
> 

Yes. KVM is also delta-based. Therefore, reset last_steal to run_delay so that
the delta starts from zero and is accumulated into the per-vCPU stealtime shared
memory.

> Would you mind harmonising this for native and Xen steal time
> processing as you change it, please? They should be (and should remain)
> fairly much identical.
> 

Will do. Thank you very much!

Dongli Zhang

