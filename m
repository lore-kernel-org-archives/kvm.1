Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087A3BF68C;
	Mon, 23 Mar 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285974; cv=fail; b=O+wmrS0za9Uz7LtU1H7ZcimXtR7zofUVo2iSoSY7Idu1ZVKsCLbtn20fYgHeK4LNyvniWcajaS99gxx25RE1lGEVihk9lhu2ScHSnxXHhTisYAGGCC/WeYh/+kBbS6ruuteHZYSGztFa+8brHmoa4MY30LUHL5BYj+Nhn65cbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285974; c=relaxed/simple;
	bh=h6QLldUTqXQYlrN4rZQ0gAHQ3CWNwBJC1zWTFSuRq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGm9n7WzkGg71vj5MNIeDykW4QKQQUkV6/mWNGAyUkLK2T/X04zjoBHI/jjb+ucZfXs04TfNOEGifdH4pEOqGRK/9tNmu71d8jRHRXGNeld28S1eeXrKk+cazHWRnEGf+uCxNRxkr6SNfY8OoUQf5Nw7LKXLTVgMNlaWxokYcMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmnF37PT; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmnF37PT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6Oqc6ubsoPrlN5XGnxxrcdOEueol2X2QtTl9vmbN43DCv1c4QrCrZFLSaH2EZweaEL/RMW8P3H7n81qM+opw+a3F2n94OGE87qs0eAuRjWjWrIIfcMlzwSem/AKKkKYrf+gTBKCplJj22FtOXDkeS9THQZ484/FE6rVqH5NLf1VUkFVYdVqbUfLwLO1JPwGWqGtb2HDEm+Mf90Il6sw65+ZunrH/2zvVhHNIYAyaEUgWAJtTRhIph+Ek74DOp7DrjxNQGSmHvFPDu6iGHQLRb0yPyJ/kaHQgcPAXty3z6hDI3VPyJq0/DXySdGsPXvqo+IMdJXOk2ZKgTMqyv/QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5RhtCdignLmEapE7XeS9KsBQ8cd7Mf+E6+NEZ+qp30=;
 b=fWLc2qp/fel9VKP4sVuUSi6wZrBL8i2rONzYDm5u+gs0xodbygbvjxOYEln6tzY0Oa4FybII77rgsspok5IUCTg6PG5PopWrerqIqomQ771alAmdcyBlftMPEe1CX0G5yNxaoLbztBUGJI0pphAJlWuVKprufVbDwkIQKKDMsB+iuE9cANjZz3Mp6H3BMFiE74e9oGWNsOzf8+eDFrMJeIL7Mi09e9GmxiNuozi9u7pfbjhsn2A+Wmfr8rPD0Mf7yPgRBHkHNfit83Xv9DZj9D3QNicbfykmZiIYRqykPnVS9THeE3q3jWiz4uK0JlC7wIaXL+5x1e+kqH6+4t9nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RhtCdignLmEapE7XeS9KsBQ8cd7Mf+E6+NEZ+qp30=;
 b=UmnF37PTbVkpVv3L/Yy0H7z28XRN5DwRNVeBWfb/4Xb3n1GnlziYoYbPCxApqTns/yAgCrKb+8KDgKOIoXY5qj3tJI5z/XItNPtbgW2cAOQK0JDoDrZIn9gj7uPfZJPk4wxCQ1HyxvehF5z2kt/2Fq/rSFl1Wb8rD1PoZ8pwu5DHD5tHdvRJk3nJoISgeiqo9VsgmTa2sp7yswh9cqWZI/5ofNoYjKD7VC3iCfrXrw7k9ZJx7ZuidzeeOZ4QeKqgQ9wjny+h0mP847DOmxhp57Uz716/Nzyt+f3//PRnqhu0nBEi/LnR1Xwi4iuIrh4HKdTrYarYBN5nYpHYOGExlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 17:12:49 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:12:49 +0000
Date: Mon, 23 Mar 2026 13:12:47 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>, Yury Norov <yury.norov@gmail.com>,
	David Howells <dhowells@redhat.com>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH] lib: count_zeros: unify count_{leading,trailing}_zeros()
Message-ID: <acF0j03j5F0ysYT7@yury>
References: <20260323170032.109858-1-ynorov@nvidia.com>
 <acFz7bEUchB2Arx7@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFz7bEUchB2Arx7@ashevche-desk.local>
X-ClientProxiedBy: BN0PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:408:e9::11) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c58f89c-5b1c-4514-56fd-08de88ff68ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B2NKcnlg4a3nm8tYLDua0ThhTbSxMFMWwWcKd0N6XLBuntmdx0vvRrk2UyktFQgctfIRYkqJpkjqss8GnXYkBcpIAbJoee2g6vvl5vCnumF9vrrBbyjwJlqVncgb8VUDmwaDTU+ex7+EJDPLKAv8m5i3Q8KRHEbR0J1np+jBQ/QT0/wY4S4/mEoSQFtv+4W+Z2zNW7OoMXtQUBuHRXADTXL+5f9fpZlTAgJTDSIdhs5QZ05IKbefnWevM7PJ56OvWkK44B+nRsQA6rVlm5WahCWE0NDLo2sClRQyd32SqRTjkqMFW4y4sPgnZIxcAIjb+8aP4pqIripQU3DoULDB6HNHCU1HOmm0yONW0oIAWMZ6JXByk8d9xP+PSISsyBArrXWkf7Y7Gv97cFJoBh1OPLOuk6GKWKLoj53y9tYqqzvQphGVechLrS8OgxL6Iccoaq8zwd76HLLtBv5MwCeRHJJDsCHRNjkTYS17ru9nQ3JKGUncU2JswzCKhlL7QazLbMo8ZO8j55YKh2uT84EApy2mmm24+Lz4t7KDf3YYnfuN6WuJyUo2ewMSeqHUXA4KP75r83070Sz/UEKOG7sUkryAISCjIz6ZFac9G2M7pHfIPo7nBHsPemxg0/PkhBH8QukPCPrvM6zQ8K6TQPPTV5UQv7pc5eo4DRx4g5pEu+sNtzs6/1/0r20/PaMmxrC+AQ9o+oFPQM829kJ1QCBuJXXEOsTIevfQH11oUVA30QQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ah70rTSQ5t4BPCXAtp5Iu1IusL6hEi43TzzJNKivJ3Dli2RZCMkQeTd0LSJK?=
 =?us-ascii?Q?JBKbH9zIwpITYi5gYMh7xO0Lv9maMcX2xZwwAnJ7kagAp+2gkfMn29eBkFB+?=
 =?us-ascii?Q?hhGKe6jUuGDk6Uu/OxT6jMMG9i5QJl9ppo7gVujvBT44KopUA8SNTno8zQzf?=
 =?us-ascii?Q?lua9PpSyzVGhtgZ99VUzVIJDUKJ1Fg9jUQp9syP/G5aidRdzQcRVSY9CJVGO?=
 =?us-ascii?Q?XElveknOhkMmXQgxx5ljVhVTliFQE98WRt75MdMCImgzZkT1lz112E2jeenl?=
 =?us-ascii?Q?2HloauXOhU+tjtZ/JZURNjoH93Ej/v+pLBmE5A0L0e8WnPgfs5UITsj9cyEi?=
 =?us-ascii?Q?T7+sdqtXf+coi7x2wULTdnHpmjd3MiXCxQQZMttEPz0Lp056Q/QqP6KqPrrn?=
 =?us-ascii?Q?7cetCyG1Jno/tCuATXgVhFyAQxhpp06p+rouWv9Z2QYBk20UsRWExSMkkkIi?=
 =?us-ascii?Q?SeSqhmJ3mWb0RhZvqfnq9VewgveOgEaCSdzU2b9g+ebmlgY3I4lPCjOg1fYb?=
 =?us-ascii?Q?Zmfdf1ZoXvvcVxMS2BsYcuzdlOjZfalCe57JzG6VT0Ayqnf286mxEJCiYlcV?=
 =?us-ascii?Q?FT3CiZKVcjMMl8S/WkW95y/RGU5UQNWCD/y//v59WV6IwWrZ+qxgpKTd0f8c?=
 =?us-ascii?Q?e0tTJhYVK/bgo9cLdmzM359em8o+AjTe9zi8FvF8/W5CR3ZRa+ljguB8cwXq?=
 =?us-ascii?Q?FmPRPIl4eEtKvOgdJNDWbSdX8qCSJx+wBXXNnPieHJujXdCKH8P3CfIVWebH?=
 =?us-ascii?Q?IX8Rty1tyhDksR9CzWAU7UcPu3KpwcnUMdlhi/xGICbcwg78kV8c5hDmToY8?=
 =?us-ascii?Q?7WhKY8PMuxN8BTskwrZY0avN1IotepF2JEoWuox/Ac0EnKsPEdf2/rvigDMC?=
 =?us-ascii?Q?Dz/Aq608m+glSYblwzFXCKRrukcVOmTwPY5keHSfR7QJkV9J+p5TrW9vhiB0?=
 =?us-ascii?Q?IPr2yI2W12kSyCCxAZJfPzSulqzbLvw54KoOZlbGiQBX0Cor4Fm3jFNhYvjL?=
 =?us-ascii?Q?cBT5WdYy6QMKHVBwx9BhjXDYCoVV3alRDg0dRtv5PUUoV3dYiaU/UnRazL68?=
 =?us-ascii?Q?6xUrV1qjtIFC72KyR6K5ZifKT0g3JBFqwwLhW42KH3AktZgyjgcJbXWrA5U5?=
 =?us-ascii?Q?lEYT5IMoWG4w1xvfq0WYsDyHAiRN0sN6Srtggx24KajbXflWFZW8nFt/yzIg?=
 =?us-ascii?Q?GE9FNrp7IwG0bKW1ickpQQGrc0GNZW8wR09cvavmh/gCfQCn5ixVOOr6Ks4E?=
 =?us-ascii?Q?+ulOk6ujPSC+buu6etxCk8IyEeaoMvrq+zFmvfjdWKDqDB3rldiv+FoYJgBB?=
 =?us-ascii?Q?LX5Qa8YDSZEGAKtBnVaE9B1VC2hZvVYgoyvOtEewaQUtR3HbfkND45JL+LeG?=
 =?us-ascii?Q?8GKR8RLmk4QsnIoa3oXtrT4oDTXvGROhKxJvzhHM0jRaKBwspy3/DR82RjQ3?=
 =?us-ascii?Q?JzI3tk+Ukmca65FG8Qo8rh3lbuhOFKjIxdoMiceci+/J3MEcwNrVmlKt/tUH?=
 =?us-ascii?Q?mGRgn5hHzv9me8KmlFM2Fzepq0QHMkIApbLFlmPNI7VObICKxIBbhtTNMFA+?=
 =?us-ascii?Q?KIVudtGRe1tInSTsFx6Qr9fYhFhUaoRdktPSMEdL2DonDtgDFNY0xA8oFEEY?=
 =?us-ascii?Q?7mY5UPfTYZfHkuzLU/6P4tHbNUetfzokqOcxaZtqJSknmrL0k7ZHbNyGynx3?=
 =?us-ascii?Q?zkWWxIAyKytiEsPFSAflGKlCzjp+9Brgvqpo6SZfE7wjnK5oqZJ+9VR9X3r3?=
 =?us-ascii?Q?aNwe6Ed2HURvNpOXO1lumpvpybkZbvEXF+pbcn4TDXfmDSlQLxC3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c58f89c-5b1c-4514-56fd-08de88ff68ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:12:49.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ+6MFLKDLXQIht+K+FwE0J3+FB1ZrtH/40mmuQ6fc4sr5No1YQ+UJ+H8RlZlaXi5GtlgPm29jYDJ++VmpfVvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

On Mon, Mar 23, 2026 at 07:10:05PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2026 at 01:00:32PM -0400, Yury Norov wrote:
> > The 'leading' helper returns BITS_PER_LONG if x == 0, while 'trailing'
> > one returns COUNT_TRAILING_ZEROS_0, which turns to be -1.
> > 
> > None of the current users explicitly check the returned value for
> > COUNT_TRAILING_ZEROS_0, except the loongarch, which tests implicitly
> > for the '>= 0'.
> > 
> > So, align count_trailing_zeros() with the count_leading_zeros(), and
> > simplify the loongarch handling.
> 
> Makes sense,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks, Andy. Moving in -next for testing then.
