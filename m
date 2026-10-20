Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493378;
	b=zMM17paPEB/wElysH6uut+HNyUTqgyzm59dRjlTKV3w/r+CJNYNw4pDDS7QKgvaTm4oz
	 HibGajBRd5v2iGmfx/os+GyZ4iSB2WBIzk4QbFta7DNjE4E+NN0YHCEWBdoC0fU/o7tcv
	 TEsCzxa9ZaV3s2pzLeN6SYP+OG9d4wvlPFtdXiPJIeaoaHsBjiToSL+rgRHe3pPCBBXNm
	 LBQASXxI2AFLefwAY4SyT+p50xr4uzDSEuRCwqcj3wq88YWx+qbfL+DlLuWtdyupQJKGb
	 oMcxRjToncjFxao8PAfk3QMTJPUn5SH3344WLIFxTGMNMWBWLEg3utSHSf5aDPH8EFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493378;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=0IAJt0UD2BHY2aeJtNI3vxcEoKPgyvku96KOQdFfo40=;
	b=REb4gkmauUBTxSQJpTabF0Mx/uXHs6gkoBb7ypIudfnxC41HAW1UVRws+Z4hqPG7rdpt
	 c5+XKjj7TaiG1K1EAOXlTrGbZ+zhV+h0ifN8FqUgLh2N5PxyfwqNE7hCYidWRMlxbeBBP
	 d77U9l5zgWgMNN1rXZ4seZBvbzgSLOnUH9jGQtK6b7XfEloOYAG8M52j/amUUR3wS+PaN
	 TYHzGWi9FMOpH5To70RUT+eWxMyfUIEZ1zuXEVDgHFnw5icInxv55UqOpKQJSHSO6Cj5X
	 XE0mliMTFQJeGkCAWM/GUV3XjhPVfcev82Jxw9lWVO4ltxW6F/zAmkqJ3/VM2sOylWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XheSlepi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54160A2602
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D54160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XheSlepi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IAJt0UD2BHY2aeJtNI3vxcEoKPgyvku96KOQdFfo40=;
	b=XheSlepiYjPkn54MxEPdmfieiKmPuuCRZGsrjvsxWUqOS4+k3u9VGuwRYDQfzdM4qiHhEB
	xg4hWPTGtW5dbfwKWzYE/59WQptKpITrD5Ft+bDE5A94PLVJP5vPkTokpaVYKw3VeVmtFr
	HxJk+7zLqkF2un4FYycSKl/ZqoNPeDo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-f6pkGtb9O-GKxmFhJLnr0g-1; Tue,
 20 Oct 2026 10:49:33 +0000
X-MC-Unique: f6pkGtb9O-GKxmFhJLnr0g-1
X-Mimecast-MFC-AGG-ID: f6pkGtb9O-GKxmFhJLnr0g_1792493369
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96BF018011E7;
	Tue, 20 Oct 2026 10:49:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07CCA418;
	Tue, 20 Oct 2026 10:49:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:53 +0400
Subject: [PATCH v7 36/65] net/colo-compare: fix max_queue_size setter
 visitor type
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-36-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2Ht6gW7AXC+9m2hyIj3XjReAS0cmbqbO/nhhR3s10ik=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaBju/eY1bBbqeZbyaaIna3yDT1YO5S2ZfK
 Dk+TjopPr+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5dQZD/9+OPsZ+9wdTvZlJAHJ8LdZ+1IrTm8SRc4WfgMoVaUgmxvUmArgHB8hI32zhhT+Ba88j5h
 KVa4ATUp8pq0eFWpUQQliSGEcG8IcvbDzwCdXHlbCyx1nenDacuX0x1Xzy6lOPsZkDaLW4sd1av
 aslU4lzEjPo+woZOS+f31o8bS96Uj4DK9zSO/2jZS60JmsZVWU2RuRFsQ4ynCztQC5WVe561WiF
 Neo8iP9N1N6jRWQ/W9lDjOjhSLPfoogGEELTAUdypajGDPuGgyGOUNHGrXgAoT6RZ9LSPkaXi9M
 YVb+sG/RbGXWjlrdd/CFkcXWKmRvs4HZYOoCxI3XLPjngyKh4mXKogIvBPZkZyD1Mc01f37OWJJ
 Z601T1TKyOwOevdMSa3zjfTSInCHXtBGcfygNJ1EHaIfbfspA5GBA6TYOD34MkYVQ7Xo0EMeDYd
 ZIRp02UPolMQALQO0ANg3mVOP62D3BNsyhxHxlfjumfHsGoGYZ6mHjkjkO/PzHDEye+BfFcPcE1
 op8EVu1uAVHHecAerzTbPZ2xi8hfaVgovOLMJe0DIozxp7l06V9c+bbZegHgr1qr0kr+5Z1dy+b
 cGCIdsvGHbP8dorXb8/DNE5clHvwjDTMX8mVMgxx/XbT5GQClDJRTRj2mTFy/Cr8znwahtft6UL
 2RCiOOUs4aDYIGg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The setter was using visit_type_uint64, accepting values wider than
the uint32_t field. Use visit_type_uint32 to match the getter, field,
and typename.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 948a2f7f9e4b..a6910de869ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1129,9 +1129,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
                                const char *name, void *opaque,
                                Error **errp)
 {
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_uint64(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.56.0.116.g6de20f6092dc

