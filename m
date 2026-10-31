Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468759;
	b=hQP3EUmVWepcVkxUZiB9Or3S7cKnw6KdpjgtcSL265wfE6CmdA80lL/liEUqq9ug2fPt
	 gFU6w6m8CnulgCmdpQ3w7UgY1cjzxGN9ACIAEtTb0ZHpVeGRbrWY2rswb109iSciBelhe
	 tCB8BBymq5aP+2srl5rgCnVg+tuBgD2K1ZxlWl1hFHHvT3WPr0PXjEUrzFNqZjM5xUAAm
	 kyul6YrvJdxtO6ZuhXardUPI1wq3mAnHu7oqSZpxPSrX99F2z4dVBBcAb2oZbwcBA1G0N
	 uXRvAY9dp76dGQnW/HKK0Q8PSJBYaHMrUjzOC/Wb5nEk1ZZ5xFNgt8ro6EdJWCZok4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
	b=GtWv8aGx0GN6ah4CnkSaME6N8Dc28F63+jJAZhUxa7PjtkdttkeG9JqiDgC9VJlNLbwD
	 0AY0RlrVttIJMgWwL43lWdBOg6XjtOR4Vg/lmCSTwOCIm+vRxtLAmb+T292C8jdrcCIkw
	 vwL17lxwtH5cRme0qRs2baEva9gUGzR3paST/vGoB+2x75KzexZBViAthKRM5iTftmr6v
	 qIoVXjykUI8Td7o14/YXXYlLnNak8aur2athVHLJ7K2T5aFPtMndhIojDNZ0+4WGvLRXb
	 rWB4lUZLTrB6DW/PBE1Me992uXx0Glifv9SeyFrlu9NyAFbqE4KP8RV6lDKMHGlAjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="zwMF/BaM";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97860606A337
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 17:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97860606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=AILMGxYi;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zwMF/BaM
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDnhup3698046
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uJK3
	1gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=; b=AILMGxYihFp4aa47RKE3
	ZkwqpaFA/qji9U4eUXttEpbkTO8SzOmW54oWCpknvVgzl3mlXPDw7zISGHqOQ5xm
	mUHbR90Kuj8TtuommrbOsRAj9DroiV9GS9MqnHAmF0hvy+n8Imz+EI0PPrrwJuBD
	yLxHW3VlUTIHnuCKnMf8tEub5zv7WtQp+JHjzoN40noj4J8gTkjguypnodlpcu/8
	NgMQDZnao+Vaeb8PuQ9M1WCCPQMUkREXnnKxJlcYGxMJK3INHKXWh0SSY6wJUkVs
	EvXP7WtDhAqEltlCeRJAkzQ4vOoU0PltSMQEjRBYrLSOk2LrhVu1cl6Kwbr+b/Sx
	ag==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hn2xhvj4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 13:45:57 -0400 (EDT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c0bad5ec1cso489217137.1
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468757; x=1794073557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=zwMF/BaM5iGwD6F+A3Iw1vEE0u5i2B6KFd6kQmlU+GzKzHqZHYRh4RB3Yjyv2rckOf
         vyQ2hiEN/8SJ5CGU8v3Mf+8V8vrPHhAk0mZkqv9Rd779LHn8+PgEzBmhqVfWos0keRae
         5wYbaohJguiZWjfTokED5f1nOvb6FdOGyZ0TV/F7Dgn+/FhH0BNgFqsTMj2JT+ZtC3QI
         48NLTtvJ78cuETjPgccHSBCJZg6aSfENzLzGgo+e3L5o+AV/tdktHmgMf7Zo78JJVGIH
         qZywLnosEWgorXG+L3nwKGsJYJl9rqpjxUM66/j9hKiRMbdpZn23EjsjlAKjOZcwOOvP
         cxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468757; x=1794073557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJK31gSrSbi0TRnAn4Tp1KO1O5wMsYESY22JYVALKec=;
        b=t3186mHSYo0zD+lHOH0BPAjFKXMbTh0TRGlyCrKlh1b5YHckdw2GP9lJjlNY5JOQsI
         Y2YTwLW2TkbpkP+Z7FLZMdK5KoQJMY4MVDgBb+myHRXFp45vGLb6JlNFyk28TN9mRY2C
         7JO5t6C0Ezoj+HsHGNwuUFMlUFwuPjVQYjA80Jh3cbvxo85SYurnAfY9Eh9G1HfFwNYa
         D6snQNTEc7U+P+2Giswc519wVYi//o9VQe3lEKWMHOqPH3dzz4RPnNrPdGgJ9/vymjiE
         BH7UtwXr6lgpNkyWOmao5Bz5q7JmrYpvdJHEeP9YAVTUetGnIUrMkNgCyPkFXI9cdHB+
         G6uw==
X-Gm-Message-State: AFq9FYJib20hnwu7YVOF6pEll9XxMDLSr39aKBjQUFVgrP3aUYKs1sIZ
	mAorP8McJf3PJGpb+by1HnwKk/WY0NH5aq1ZujJ4RJ104ftz+j8vvZDD1YO9S9nWXGDs2Q6VDhL
	uiqRc550GULKuDFGZqptSnXZ8Ai+jgWfiGLLryZLkionOEDGzwg==
X-Gm-Gg: AYBFou2x9wIRUwP0vzomn4xUjZbBJmb/SLE9htDZZxWdK6XDyE6PJb5a6uKu5KfrPeT
	ZqjhQKC7Q/gJBj0iOSnrblytLKOT0LPmYyp9z5s+wGr90+NrYf+mh6oS6v4yWV3LTvENK4I6dEM
	0lLStRdCfH0h8SeQkD28LmywXi4VUP0cI3wnjNk7GuaGmLu9brGL13bW2H+Dg3OCHG0JoZ3H8YY
	uErANHt4l3ovHB2stTX6EFvI66B+VWdWqhN/DI9KYXyfO/ejdahrasffCoFlGHvKUJJ/2k/0Nmb
	EcUTfPWh6AJvkEvknNinbytRta79J5hpMYlFGVEecJ2RRgDlTcYOZqP6CacYhlpc5J8JmNxFokh
	6n50Wbb5Oon6fxBZ52uln/xLQhfsH/pUckH7fBQULoLl33/O2oANuFmCwEQ==
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098028137.28.1793468756675;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
X-Received: by 2002:a67:e103:0:b0:7cc:226a:f963 with SMTP id ada2fe7eead31-7d072cc29e5mr2098018137.28.1793468756238;
        Sat, 31 Oct 2026 10:45:56 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 31 Oct 2026 13:45:34 -0400
Subject: [PATCH 1/2] vhost-vdpa: fix pinned page leak in
 vhost_vdpa_pa_map() error path
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=2574;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2cfbyA5E1BgeuOs5GH6EveuwRPzjMvx0EL0D8iIR4TI=;
 b=ASB3o36C4fU3EYWb71QWR0b3OloFHUbllnjysWZc/O/WJMEbMyalbSxUjvtUsiJCSd5hwtbVN
 UV1UmC6jYICARYL7Qn5AYWXOvVzIfj1mcr+UxfTHO1a4QhwHfdFBPLf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: Pfuj-TDvu1T_xEsP9ulrh5cccpHcXkvp
X-Proofpoint-ORIG-GUID: Pfuj-TDvu1T_xEsP9ulrh5cccpHcXkvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX/IHNYo2B/gnV
 cPvtFUp6/mw7J6fzHsh9jgBM5sVH/wAdRgiQUHttGYY+DyTUdTdsHHHIiMZLJ4dz7CZqu5mzrv2
 94z4Hf4+kWLRS5zZzjPkQlYW3IDgJ80Ig4zkxdfjWRQuCr8e44AQnFLmluYmRYy8eG9Vz1mWA6/
 pNkXKHlNxc1MNLyLCgYUzj07Nv2SUJloLeLzeZqoxdTEGr9Vl0763+bW8dUQuuad7H41S7wgGte
 L54dH3IHNXZEj0oON6JW+E+vpb6g814y4k/dqV+vlZmxVGprsf38a6IQfKkDpDkOg247tvi17E0
 D6E2YytkcvDmiCRyRVTMbUuKJWI8hIAwfu1imWVKA+WD2J+FkBeMbjxU6CAGJ8pXNNk7030jzIc
 fUCmSQnthNTvAP/CrKfzBpkz95/gNU5lpygH4PNCF4w+IFOVBcH7KqqOdRoB2iJs9Z6nwSBNRLo
 ncf0sX8ZVJSpokZGCig==
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6ae62955 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=Vli3z_CPQh-YiPf8mvEA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX2Cn9u99wspp3
 aaVio991CFvu8eZERQIVJPKVPq1qh3rY6JBWXue8zlc/P+1080oJKpzBqhRk51TUujO5Bfb0rhX
 m4lznMpcR2zfnCN5nCuLwJOITx3hAU4ustllqtNG0mwS3OaADeGS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=10 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=10 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ff7d90719171..d9af728942b3 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,7 +1151,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -1187,7 +1187,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -1202,7 +1201,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -1233,7 +1231,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -1248,7 +1245,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm, NULL);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -1260,7 +1257,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}

-- 
2.39.5

