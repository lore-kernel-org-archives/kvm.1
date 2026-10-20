Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493228;
	b=BuxF0dY7PhsWNd0A3YbQXAs93RaT6cKcUP+zz/Fkr4STqfpCMMPIzyoX8OwYheRFljlV
	 x9GkcseO+7FIFTCsLXpNemwZ5/XpUb44Az6YW8d04QRD+x0RZ7/+BE2YaXLq5tFIXGk1C
	 MuP6A1WsNBn5PrSZIuokYJ0vLe5fiOGvavKFf4tUayAXd7ewrgYl2ZJ0k160gJ8CpmyRO
	 TVmXqdJHCe+AnlDoJ7yePKaUtBStKKGzcmMk9grQe4pyK2lJKyfUB/66s3iVFuy2w7AE4
	 EujqZYLKq4kg7OnbrL0I3XVjFPN4SJVeeXlSYt7nslYnyO4h3MKstaphUrYSFr+YcMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493228;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=ABGJlqhjTzuYRZnmPc116ozStZtH+NrxbC+tSxh9ams=;
	b=uZEjQcsvitmgaumprbpgk0JjrXecaa3ilFglkgkfBiLPx5sd6pHjheL8cBJAr8gegpWF
	 TcgsvMZEM94xB1oJLhXJf/gxSEd5Ft1klAt9HcmhQ3H2CYv3c3PMlcZ5WybND2t9WOpG5
	 P8EM54YBvRbadXQt/PYZP2NkDBdIOpImleIrENmS0rTulf7ntKT0eumY1HtSqTYRmrDVY
	 PrJ2te8Bs0+9gz7VAhZk7qHebQSxh9Q05+e/JtkZapXHVU4gwHY2aoucc0cbnXSrLkDvl
	 OSW1vMgdrUG/b/f7zy1vrHk7sRRiyMsjKaFz/XMnhZk/ND0zAPW0Wq7h5TwqiCIVFlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EixwMFHv;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8004606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8004606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EixwMFHv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABGJlqhjTzuYRZnmPc116ozStZtH+NrxbC+tSxh9ams=;
	b=EixwMFHvTimPrYLZp7+w5IYqM2gBc2eRfW0oaQmhK0dKDRZN53jlO7IkGJRJ4yUyWklcKf
	MIGKbasrVncQMU+cfbUt4L092DG4znK85OhlnNFSPK0EREu1jRc5mg21JkA2F+DPct9qVo
	+D6/dHDgyMo2cNWpqGAYWZfIXpd26tQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-c5deni3IOC2wghL_mDuwjA-1; Tue,
 20 Oct 2026 10:47:02 +0000
X-MC-Unique: c5deni3IOC2wghL_mDuwjA-1
X-Mimecast-MFC-AGG-ID: c5deni3IOC2wghL_mDuwjA_1792493219
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2CAE1800BD4;
	Tue, 20 Oct 2026 10:46:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66E731956088;
	Tue, 20 Oct 2026 10:46:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:25 +0400
Subject: [PATCH v7 08/65] qapi/gen: fix _module_basename for multi-dash
 'what' parameters
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
Message-Id: <20261020-qom-qapi-v7-8-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OXQAJj92qnLHVy/ekT2tV/E7DqxlrqwyneXLdAaw748=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYkpNZTiTu/0NKP25uG6QN+n4wrDZMxyVQO
 X1gFQ2YGniJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5Tm3EACDRom1wjYZ0S5SCUsfw8t+j56evvGukUBRwQKN2w3Du6uYAw4nS9RuGSZhu8Qnd+u5pMZ
 RR4HP3oxzkczsRTA8h9qgVMNqhnT0wlElBiABH9tCI3YJUEmCvZ6BcLxuFPzfBeyc9GxW13b1zO
 eFJpHhMeM/R3jK04zRuRqksv4/8kXnR6/wpqoTWxFKiLIHlDVBwA/CTfIs4nGprg3ZGZmRlb33o
 EmNs25MODVt3L329BQIU0WG7OwYkXsYoGUdf4ZEbcr9CZywiZ8S0Rvx9fyqeYkVfaSlmqy1IM8D
 gBphVT/878S1qnGZqgmJs2Mb/btw8aPl7PQPV5lHDeMKBfwNHCoePHXNHb7C36F9khg3w29QQGl
 cKkIx32v/w3/L0dR1CWVI+YkbZ7xfh8oZJabF87gg5+jzpgm0AhaVUIgHU33CwJpYm2u62IUU6O
 GUxREslEK8bfz4pPnfxyzQVd8JIjSZoz7J2ip2+0PYyI8mftsOWTAFnUU8jnITGf2UjSAGRfXtR
 DTXKPDqAwHdk7bX3rSvoybxG2RnFNFluw+yjjhDEyY/RhYpOJItxVCbcr+e3/wkbhBjbIiHOO14
 e3pUpNugRf71Qh75I/eHU/GjXdHLvK/PibBXQ7ZxPFfUTuBYAVOQILNa2K4bAzoDOqwVFf9OOq/
 UAbLSh+VqcTxYTw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b024..690187d4280d 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -300,7 +300,7 @@ def _module_basename(self, what: str, name: str) -> str:
                 ret += '-' + os.path.splitext(basename)[0]
         else:
             assert QAPISchemaModule.is_system_module(name)
-            ret += re.sub(r'-', '-' + name[2:] + '-', what)
+            ret += re.sub(r'-', '-' + name[2:] + '-', what, count=1)
         return ret
 
     def _module_filename(self, what: str, name: str) -> str:

-- 
2.56.0.116.g6de20f6092dc

