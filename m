Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795273179;
	b=pEsRcMkmUkn7QMSjy9kHzeD2EE2wKIHettQsi8p/rc1gfn77LLVQ9aOynoV3wZVFeoAc
	 g4e6d5xX8lZa6/qAmWmWixG0jU6sCGi8fyfJL56eXg014vlol3yn/QQBMMgy7ZASOur8f
	 WByUv8sgUEj3y08g8XmWFcl4LpRPfN+ZGTemaMOeRwrCQRpHeHDYwUdO2IhD6wwL6Psfv
	 Ur+fNYkp2BSdVYh4L5pl3jpnifkJ35jaIWnWWNbcKFa2RY2uWHpF6aUdh+KYXmChrxW9d
	 6y0gZtEviF1Qjweih50WCXMpOz5cfS0p3iMPl/EBqlTtF0yiaTMpWQN60agM0nFSJzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273179;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QGLKBJGKJmG8wTC85yxU4LzEhwN+ufN/tKb6of50/Sw=;
	b=w3D2SQqC8uV7U2EImlILqiykHBlcC7AwW659KgfUGvh4IYHi/bXHIMhKyPYxWfXpv4Lp
	 jUtWQX2nLHrtyDrqsQ1gudOulbNWD8+pGzPkwoLdQDm/aJQRCKZXe2/roFO0J7Qg2TNnZ
	 7MpjtI9FXaWqM9EHkIWHheb8lTQUd6UuGrqspqY8blkhOIYfBMVe90UmjPwoJTJJbrYoL
	 GWdf6yzXvh5Y+zvjggWmobFI/1ROGrvMWgXl9REpGwZv9hTcKfr3sztrw/t4NBiE1lhX4
	 IHM/dq4ytS0B+DOYZ+JegIOL/aRcLGKpSXPSNTXr1CMglLqhGNKhd7YkkekF6Yh2oIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=MmyNSjg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.84
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C61606A320;
	Sat, 21 Nov 2026 14:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C61606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=MmyNSjg3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P51rUx8cZa0p2i/KTSqtMsRMbp7p3LcqKgOnUTFYrOu0w+NCiBkcHnLEWd0flzxc0BAQs4cotGzWhL7EaDX2NcXifqs+IA8GtYUM0pmih6/aqHUkIHM+YKqgCYyndITu/F6pJiEWFTh3TAJtL+52mq4cbOFsNXevpKkJorVVDgwetceWcIQeKBRznZa9QADdHZeBSldx4zvIyYCiH0hti3uyVag8DWnRTOimBHVEXxfg30o5xuoszqZKcEV6rcrz9AVgZh8S6c1t8RC/jRFEQ5/8Icmt829k//Wm0xDkEvWSkiYZU4Eo+AgkvKbdn1+IvhbIkNJBU1VW5fyKQLXFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGLKBJGKJmG8wTC85yxU4LzEhwN+ufN/tKb6of50/Sw=;
 b=tNe1BIKrtNDyQ5aHCrdRcxjnJ2OpZj9nBbdaRZSl51vSVJGOOLfyIDc2MprooBuOlaBIQSt5Kik4B/AqLzB8WYMH1o1BObBUcyDLzji4Q2KeE7e8NfDN4624QfXlSuB/Y2I7CY8rPnqDWRqBDVSb225YRG+oGhmF9XDdnO9PINOlaJq/yV3DJyoErffxZ4+hbzqE+S8sVlJNwaGrBcH6t/AHXnjd3t+HRWvHu4o/rEo0J2CMRS4ERR0HkzUZ/gt806z9iml4i6ogPg5+Ul8V09+H9y4pudBBeTce1UU8Pcy7WZ7u+ue6g61rcWnjKHzZmXTVTKxHcsVQdgQC0214lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGLKBJGKJmG8wTC85yxU4LzEhwN+ufN/tKb6of50/Sw=;
 b=MmyNSjg38Q/D58y7WL+pU5vz4iepRATldu8pOyshggzDQCTxTiN8LfybuirzZ6pcxZZ5xW7zmJfqs54fdfACcu5i5y8JcjRuwtqu5AkJqa9J9CN77mjZXALc3l/j78pNT7OGgeNyMDbk0jZsoGahKaQS9qvw90jgVgHxX77fbB8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4177.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 14:59:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 14:59:35 +0000
Date: Sat, 21 Nov 2026 23:59:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Batch user accesses when updating steal
 time
Message-ID: <awGevuQAuA349gO8@z790sl>
References: <20261118062242.2914385-1-den@valinux.co.jp>
 <20261118062242.2914385-2-den@valinux.co.jp>
 <awB1hZGh3LYztjqL@orel>
 <awB6FpVOpZ9fhMt1@z790sl>
 <awGJaUFUmBOa4xfO@orel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awGJaUFUmBOa4xfO@orel>
X-ClientProxiedBy: TY4P301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e5fece-e322-4d03-9e15-08df47e00e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|7416014|376014|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|10067099003|4143699003|56012099006|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	F4bPLYUZbCQ7oOkuKaj2CyYtv8lQUSbX9KTFgX9I/1fgLbVhu7J1jqfQBCaZMNjyYh7zumyFPpR7uIEJtV5SZyw59R0A6DvTB65pKEEXylcL8l08jLvfpwgydSTjQMAOgm9x6AEQAUvGadldRYqWakMU6LSWNO7LgQu1S4rke+HYcZgXIJl0m62FQidy16SFnfQVcFV/DhHwseT84bQaCVg05WVq9iCEskoCtDSGx8/rjTMwfrFTH1Lhyj7Gr9hIlNIUrw0uROS98SXan7SFg/nTC0eTEjXGnzBWfMMF5JC54RhIq8qRoDH5lK80f8gp+F6/XkbpVG3YbyuT6LiqhRQWvTfFJA1KmLkWsfviFCC0v5paQ7cuz066O+8JAVOEn0OMPCvtUBqHDud5d3rggG9jozB4K/P+5B0ogvvpI6nsNICru7uy45fqxzb69rhNV5WeNF/Dsl0I2s5ZlXEN3tD9PExbKwOq31BWGjgDD3kQ6Ey/MVLRizcrtGPMWTcJjJ/N1xHg0BKd+4FYtGF1qrLYLVGc6bDWmVLq4qZS2sWLyoCSgG1kQM6avUNEDJs473FU2X9AN2Fav1+q4XNrpjAOtxcykAstKEGcTkZmmRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003)(4143699003)(56012099006)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okExQm1sYlTfvAD669SzVcQTKApY5A0HchtowQXKVGqz0wSKs1BE7b4Lz9C5?=
 =?us-ascii?Q?H9CvPD7F3m+RCqfuCkHb8AG0w9/SIjbqzni/WgwhUlfOn9rWTRrVyaK20Udh?=
 =?us-ascii?Q?Mvvq+TrolxMs7ufiEXDDGdI5JUjhLhrl9OIWg+BFlZvCitLXFZRmRneNQXE1?=
 =?us-ascii?Q?NxzFo5BayoRerLvpL1h1/AYHMhaKYs8Xw8dizTw/mPlUOEbq+rVwsYmbkje7?=
 =?us-ascii?Q?Ifc3gaRcbscDAS87MJr/qmexGfRuS00VFrtphECdDc79gCR5Iuo/pBYt5Cpv?=
 =?us-ascii?Q?R5ZdkC4+g8UaaZzrx4CxqcE4gu3OyDl0FA6ZIcARijTCGuSPR2bK6Xt23rq1?=
 =?us-ascii?Q?pV1yssjncjhVV6hKWQ2eYxafM/FDIobGDUavz/KcWI3PYqhpLuFFsrhlRdA+?=
 =?us-ascii?Q?+1Zm5gz40Fkg7liVPo5+thcrXwgTIm18kj6ID8ltTNCOrBHBik27gP6KRxHH?=
 =?us-ascii?Q?JbXmgmwywpzBT0Tow9CbWpM9K10ybWybnV8y4q+G8sjyzPkodP9iLTEOwSAh?=
 =?us-ascii?Q?bnHSUWsmVqFLeYhNNOoTyE/0bTh06/1XLMK6ymordsa40P/iX6RwTuZlQZjv?=
 =?us-ascii?Q?4Mqms7nJgwMTy3Of+lkAS9Qcd1JcKYZYtS9SHfR/d4IrtUXJZ11nhWWpu6qu?=
 =?us-ascii?Q?Iw9eIN2sX4ME71ucJDv7Fhvct7Eafz621UW/dzWlanUtZsG9gZdyHeA1xyUC?=
 =?us-ascii?Q?b/JA1HwTMHOIpapxNPDAswxcjzszVU+SuiZhPZ31CtguDtstf2Y0it2yrlz/?=
 =?us-ascii?Q?ZG+MWNR21qPJkZ2FVrpFLkizcnvv8BVpsmRCvGoIo+umg+U2xy5jawjHsbh9?=
 =?us-ascii?Q?C/sk4PS7RuC5m7OWTNjWFPeNkUSXCWz3JAgo6YhyiJWiPuk4wbINymPWbinO?=
 =?us-ascii?Q?tNYIpWStMrFcu9GJ9smaOIDnsId0kpyjN1fK0E6RHCq6Hr3tiWjFwYDrwcGB?=
 =?us-ascii?Q?NcEFp46F7yzRACY+ivq3O2AMhciA2a0/tZf7mQXCvrqBJm30j9DT7q7xTNvL?=
 =?us-ascii?Q?N8FnsbutNSuP7SiOQ8wOm2HCLT9pk4ajvdEEdvLVaFkXBLOCVy8I8okxKOSV?=
 =?us-ascii?Q?7IBbOa5Z7cpSu7kUWaTeuBUZCep+4J6RKGfZEOeSl6kC1/TV39vsG/0TcL1C?=
 =?us-ascii?Q?eZZmSC8h1DBWidznEDqJTlVUGKetucQXqKeIIhbIP4jOH8tiFKytBajWo2nO?=
 =?us-ascii?Q?8Fl+fvw7PORZQnnW0X/v/qRyb5r02Q2Wyod3ISgoMDXLtMBDGJiVV4nOYZTJ?=
 =?us-ascii?Q?n2JiWYf7iZNioStkV7qikvQreVdQIihAGg2lYe0Sjpfe0gdYap/awlHWB++e?=
 =?us-ascii?Q?ghD0n02n4qyBr+GUKA/0Tf+KsUJh/5aWD5vE3dr1H7Pg50tls4jASu8CGzCG?=
 =?us-ascii?Q?fHV1gfWSkHwk5ImyVkttHi4pStxaiJIeXHwNbKaYYvfVqEps+XPqZi6QlpX4?=
 =?us-ascii?Q?OMFL6x3zs6G3MNF5eKrUqrGNrRWpVlZDqlpJqWX3SWYOh52Nn6v5BAIXzsaL?=
 =?us-ascii?Q?lVZnceuv2b2M0MGIh7XqszSuopt2R5rGUOxXHqJTjq09sPjdKyxdNRcMJaFd?=
 =?us-ascii?Q?79DHGOL7mKlVhhMdLaD01Q7dMId+GNf4nZOCGDFAGA9JW2nAb7VFGaUrGcCe?=
 =?us-ascii?Q?q6uAcNk5zXx1QYVP9cxFMaGTOacBjIUZWgXwRU0uj+jJZjfDpUcawda5sMtc?=
 =?us-ascii?Q?aAiXYaWi6EtRTh1UdvslmmNhnxRqFMx6qeW5f8C1a0qjXtl3eC6EwtEF4HL6?=
 =?us-ascii?Q?Fo/1IdMbtvPRqFJHgnv9GXWQvOWyGQiy/q5BfbXw0ATCZ6C65mty?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e5fece-e322-4d03-9e15-08df47e00e3a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 14:59:34.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnJSfFP8FcI7YLx/nscpPqGEgaswXKW8HaOslbnfswnK/5Lj7B+8dkk0fCJl89QqdkLs3BVmMu4U5j+ECINBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4177

On Sat, Nov 21, 2026 at 01:23:43PM +0100, Andrew Jones wrote:
> On Sat, Nov 21, 2026 at 02:20:17AM +0900, Koichiro Den wrote:
> > On Fri, Nov 20, 2026 at 05:40:29PM +0100, Andrew Jones wrote:
> > > On Wed, Nov 18, 2026 at 03:22:41PM +0900, Koichiro Den wrote:
> > > > Updating the SBI STA shared structure performs 2x get_user() + 3x
> > > > put_user() calls, each of which toggles sstatus.SUM.
> > > > 
> > > > Keep SUM enabled across all five accesses to the shared structure.
> > > > 
> > > > Note that write barriers are added to order the odd sequence store
> > > > before the steal-time update and the even sequence store after it.
> > 
> > Hi Andrew, thanks for the review.
> > 
> > > 
> > > The barrier additions should probably be posted separately with a Fixes
> > > tag.
> > 
> > That's exactly what I wasn't sure about when I read the ISA spec.
> > It was unclear to me from the Zicsr ordering rules whether the SUM toggle in
> > the old code's get_user() and put_user() calls also order the stores to 'sequence'
> > and 'steal' as seen by another hart.
> > (I don't think they do, but I'm not 100% sure. It feels a bit like trying to
> > prove a negative, as I couldn't find a clear statement. I may have missed one
> > though. OTOH, the new code surely needs the barrier, so I included them.)
> > 
> > Do you read the spec as allowing another hart to observe those stores out of
> > order in the old code? If so, I agree the barriers can go in a separate patch.
> 
> Yes, we always needed the barriers since we need something to pair with
> the virt_rmb()'s in pv_time_steal_clock(). get/put_user weren't covering
> for that omission either because CSR accesses are weakly ordered.

Thanks. What I had in mind was the exception in [1] for a CSR access that
"modifies the execution behavior of the instruction that performs the explicit
memory access". I wondered whether toggling it between the stores in the old
code also ordered them as seen by another hart. I agree we can't rely on that.

I'll split the barriers out into the first patch of v2 and add a Fixes tag.

[1] https://docs.riscv.org/reference/isa/v20260120/unpriv/zicsr.html#5-1-1-1-csr-access-ordering

> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > To reviewers: please let me know if you'd prefer
> > > > scoped_user_rw_access() here.
> 
> For scoped_ or not, whatever you think reads the best. I prefer scoped_
> when it makes sense, as it's harder to get wrong, but readability also
> matters.

Makes sense. After polishing up the scoped_ version locally and looking at both
side by side, I now agree the scoped_ version looks a bit cleaner. I'll use it
in v2.

Thanks for the review.

Best regards,
Koichiro Den

> 
> Thanks,
> drew
