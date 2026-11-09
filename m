Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259485;
	b=VTPiAvWc1J6f2Zltlv6692DIb/U+dNTG9SHWE1KPyqMqnIwFRqmmlkSxoUsrkpc+zmzB
	 Q4kn9esRp6cwqdQeAttCAVlRMDzSU5Uc3lrT/SI52oY+G91D6JwENS+x/5TabPX7WYmll
	 Qn5tAiTElgGCNy66ehN4VPzKRoRFjaNNtCk0i2AKPRR7yL2/sX/RFGaenF0hI5HVKxs35
	 ZeAAkZTkOvbMfkT/BLpJuFjPLIOgBDKKaK1XxjYiR3Ug6/AimjycmJ743JOH/9z6/cn1f
	 +Iz6X1LPv1WOCf9CHt2ucB43ZnIXMqVtJ7ZSO4j0cjjVBNzuweiMzObF8/oVr7g1yzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t6DX2HfzO8y7eqXmuAOCeDfMXe4RiNHRXtrrOS29llc=;
	b=AYMGhawyHZj+ccQaeuVVsDQlxtWX+SNJzKw14AGHMse86ezdZ4420PhaX29VswJV0k0b
	 VjLi0YfPhCLCq1RdXUgYeb4jHhCiWaJ93o94xfZ0PBOeLCMax5NGX3f1IuOz8kxHjkDEl
	 AHvW3GH4bAynv0vXgwYfMXewUTSxYMkhHL9VddFiHrs09YUlBDAgxCjvplmrf2Vt6ZxSN
	 VeB0EaWiRKA5GEWifZv/h97j7Q3J9JjvbHhxJuAQUvVWuJrIJxYRssfYGs49IKpBAAroK
	 DplUy5xY7Rm/FNnkKBhORJEUBuMGoODLnFP161FoR/1iG8UVxHZYfVDkkT0IUrEcC7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQ9YE3Vc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0360A2608
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQ9YE3Vc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC1F1F008A2;
	Mon,  9 Nov 2026 21:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259484;
	bh=t6DX2HfzO8y7eqXmuAOCeDfMXe4RiNHRXtrrOS29llc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQ9YE3VcCr9vyYECw+H/k4MYLu41Av5tFQU03OVaF5zXQ1zZ2BV2tO2uhOcT1ozfS
	 0CfYaZ8pAzdLflrkcW20d3Rpchpx+E+rZYzENjEquPs9xkv4JQjlVo3PsE0oEPN054
	 zy8qc1jj2E4RgsAuZIy5tKe+8l0MOmRYshglNPgEurg/z3k2ODHp+T4Zr3FVVeBwmh
	 rGhYxIEhE9D9oksD9VaXEm+u6kPb3IBO3BJTEZwtBTco+RNsIg0Z3w1f3pCW9hYzm7
	 w8RpzU/IzrWZpzBsGB+vuK4chEC/XvByE1xoGLe3d/PuTDogCBqLW9Cs96lAH1BdsN
	 XqPuFdpV4R2Pw==
Message-ID: <sashiko-outbox-205666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] x86/sev: Add per-node RMPOPT windows for >2TB
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <5a2ab10ab9bc50c2f27bfd432ea30b0219ec397f.1794257678.git.ashish.kalra@amd.com>
References: <cover.1793921823.git.ashish.kalra@amd.com>
 <5a2ab10ab9bc50c2f27bfd432ea30b0219ec397f.1794257678.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:24:44 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] x86/sev: rmpopt_gb_to_node() misclassifies gb 0 and shifts
  Node 0 window
- [Medium] x86/sev: rmpopt_init() leaves rmpopt_node_work uninitialized
  for offline nodes
--

commit 48452fd940a44051bb4eac5ae9acc4e9431f65e6
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Add per-node RMPOPT windows for >2TB systems

This commit selects a per-NUMA-node 2 TB RMPOPT_BASE window using a
sliding-window search and warms each node's window in parallel on systems
with more than 2 TB of RAM.

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index a2756b18d5f7a..1ed1fba3b62dd 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
[ ... ]
> @@ -632,19 +638,125 @@ static void rmpopt_scan_range(void *arg)
>  		rmpopt(pa);
>  }
> =20
> +/* NUMA node backing the 1 GB region at index @gb, or NUMA_NO_NODE if em=
pty. */
> +static int rmpopt_gb_to_node(u64 gb)
> +{
> +	u64 pfn =3D (gb * SZ_1G) >> PAGE_SHIFT;
> +	int nid;
> +
> +	for_each_online_node(nid) {
> +		if (pfn >=3D node_start_pfn(nid) && pfn < node_end_pfn(nid))
> +			return nid;
> +	}
> +
> +	return NUMA_NO_NODE;
> +}

[Severity: Medium]
Does rmpopt_gb_to_node(0) always return NUMA_NO_NODE on x86?

trim_bios_range() reserves page 0 as E820_TYPE_RESERVED before memblock
setup, so min_low_pfn and node_start_pfn(0) are at least 1, while gb =3D 0
has pfn =3D 0.  On systems with more than 2 TB of RAM, gb =3D 0 is treated =
as
unpopulated with distance RMPOPT_EMPTY_DISTANCE (255), so when
rmpopt_find_best_window(0) slides base_gb from 0 to 1 it drops gb =3D 0
without reducing own and lowers dist, shifting Node 0's RMPOPT_BASE to at
least 1 GB and leaving [0, 1 GB) unoptimized.  Checking for range overlap
between [pfn, pfn + (SZ_1G >> PAGE_SHIFT)) and [node_start_pfn(nid),
node_end_pfn(nid)) would also handle other nodes whose start PFN is not
1 GB-aligned.

[ ... ]

> @@ -654,6 +766,14 @@ static int __init rmpopt_init(void)
>  		return -ENOMEM;
>  	}
> =20
> +	rmpopt_node_work =3D kcalloc(nr_node_ids, sizeof(*rmpopt_node_work), GF=
P_KERNEL);
> +	if (!rmpopt_node_work) {
> +		destroy_workqueue(rmpopt_wq);
> +		return -ENOMEM;
> +	}
> +	for_each_online_node(nid)
> +		INIT_WORK(&rmpopt_node_work[nid], rmpopt_warmup_fn);

[Severity: Medium]
What happens if a NUMA node is offline during rmpopt_init() and is brought
online later (for example via CXL memory or CPU hotplug)?

rmpopt_init() only calls INIT_WORK() for nodes already online at init time,
leaving rmpopt_node_work[nid] zero-initialized for offline nodes.  When
do_rmpopt_work() later iterates for_each_online_node(nid) on a >2TB system,
flush_work(&rmpopt_node_work[nid]) hits WARN_ON(!work->func) in
__flush_work(), and schedule_work_on() queues an uninitialized work_struct
if the node also has online CPUs.  Initializing across
for_each_possible_node(nid) avoids this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793921823.gi=
t.ashish.kalra@amd.com?part=3D2
